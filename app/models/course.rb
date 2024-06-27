class Course < ApplicationRecord
  belongs_to :department
  has_many :course_prerequisites, foreign_key: :course_id
  has_many :prerequisite_courses, through: :course_prerequisites, source: :prerequisite_course

  has_many :inverse_course_prerequisites, class_name: "CoursePrerequisite", foreign_key: :prerequisite_course_id
  has_many :inverse_prerequisite_courses, through: :inverse_course_prerequisites, source: :course

  has_many :course_instructors, foreign_key: :course_id
  has_many :instructors, through: :course_instructors, source: :instructor

  has_many :course_offerings
  has_many :enrollments, through: :course_offerings

  has_many :assigned_courses
  has_many :students, through: :assigned_courses, source: :student

  has_many :tests


  validates :title, presence: true
  validates :capacity, presence: true
  validates :department_id, presence: true

  def create_course(params)
    department = Department.find_by(id: params[:department_id])
    return "Department not found" unless department

    department
    course = Course.new(params)
    if course.save
      course
    else
      course.errors.full_messages
    end
  end

  def update_course(params)
    course = Course.find_by(id: params[:id])
    return "Course not found" unless course

    if course.update(params)
      course
    else
      course.errors.full_messages
    end
  end

end
