class CourseInstructor < ApplicationRecord
  belongs_to :instructor, class_name: "User", foreign_key: "instructor_id"
  belongs_to :course, class_name: "Course", foreign_key: "course_id"

  validates :instructor_id, presence: true
  validates :course_id, presence: true

  def add_instructor_to_course(params)
    course = Course.find_by(id: params[:course_id])
    return { error: "Course not found" } unless course

    instructor = Instructor.find_by(user_id: params[:instructor_id])
    return { error: "Instructor not found" } unless instructor

    # check if the instructor is already assigned to the course
    course_instructor = CourseInstructor.find_by(course_id: course.id, instructor_id: instructor.user_id)
    return { error: "Instructor already assigned to the course" } if course_instructor

    # check if the instructor and course department are same
    return { error: "Instructor and course department are not same" } if course.department_id != instructor.department_id

    course_instructor = CourseInstructor.new(course_id: course.id, instructor_id: params[:instructor_id])
    if course_instructor.save
      course_instructor
    else
      { error: course_instructor.errors.full_messages }
    end
  end

  def remove_instructor_from_course(params)
    course = Course.find_by(id: params[:course_id])
    return { error: "Course not found" } unless course

    instructor = Instructor.find_by(user_id: params[:instructor_id])
    return { error: "Instructor not found" } unless instructor

    course_instructor = CourseInstructor.find_by(course_id: course.id, instructor_id: instructor.id)
    return { error: "Instructor not found" } unless course_instructor

    if course_instructor.destroy
      { message: "Instructor removed successfully" }
    else
      { error: course_instructor.errors.full_messages }
    end
  end

end
