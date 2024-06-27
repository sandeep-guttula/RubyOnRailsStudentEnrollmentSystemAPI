class AssignedCourse < ApplicationRecord

  belongs_to :student, class_name: "User", foreign_key: "student_id"
  belongs_to :course
  belongs_to :assigned_by_instructor, class_name: "User", foreign_key: "assigned_by_instructor_id"

  def assign_course_to_student(course_id:, student_id:)
    if Current.user.role == User::INSTRUCTOR_ROLE
      course = Course.find_by(id: course_id)
      student = Student.find_by(user_id: student_id)
      instructor = Instructor.find_by(user_id: Current.user.id)
      return { error: "Course not found" } unless course
      return { error: "Student not found" } unless student

      # check if the course is already assigned to the student
      return { error: "Course already assigned to the student" } if AssignedCourse.find_by(course_id: course_id, student_id: student_id)

      if course.department_id == instructor.department_id
        assigned_course = AssignedCourse.new(
          course_id: course_id,
          student_id: student_id,
          assigned_by_instructor_id: Current.user.id
        )
        if assigned_course.save
          assigned_course
        else
          assigned_course.errors.full_messages
        end
      end
    else
      { error: "You are not authorized to perform this action" }
    end
  end
end
