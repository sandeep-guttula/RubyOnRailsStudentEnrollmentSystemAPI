class User < ApplicationRecord
  has_secure_password

  STUDENT_ROLE = "student".freeze
  INSTRUCTOR_ROLE = "instructor".freeze
  ADMIN_ROLE = "admin".freeze

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true

  attr_accessor :department_id
  attr_accessor :year_of_exp
  attr_accessor :semester_id
  after_create :create_instructor_record, if: :instructor_role?
  after_create :create_student_record, if: :student_role?

  validate :validate_password

  belongs_to :department, optional: true
  belongs_to :semester, optional: true

  has_one :instructor, dependent: :destroy
  has_one :student, dependent: :destroy

  has_many :enrollments, foreign_key: :student_id, dependent: :destroy

  has_many :assigned_courses_as_student, class_name: "AssignedCourse", foreign_key: :student_id
  has_many :assigned_courses_as_instructor, class_name: "AssignedCourse", foreign_key: :assigned_by_instructor_id
  has_many :assigned_courses, through: :assigned_courses_as_student, source: :course

  has_many :tests, foreign_key: :instructor_id
  has_many :course_instructors, foreign_key: :instructor_id
  has_many :courses, through: :course_instructors

  has_many :assigned_tests, foreign_key: :student_id

  has_many :student_answers, foreign_key: :student_id

  def create_instructor(params)
    department = Department.find_by(id: params[:department_id])
    return "Department not found" unless department
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      role: INSTRUCTOR_ROLE,
      password_confirmation: params[:password],
      department_id: params[:department_id],
      year_of_exp: params[:year_of_exp]
    )
    if user.save
      user
    else
      user.errors.full_messages
    end
  end

  def create_instructor_record
    instructor = Instructor.new(user_id: id, department_id: department_id, year_of_exp: year_of_exp)
    unless instructor.save
      errors.add(:base, "Instructor record could not be created")
      raise ActiveRecord::Rollback
    end
  end

  def update_instructor(params)
    instructor = Instructor.find_by(user_id: id)
    return "Instructor not found" unless instructor

    if instructor.update(params)
      instructor
    else
      instructor.errors.full_messages
    end
  end

  def delete_instructor(params)
    instructor = User.find_by(id: params[:id], role: INSTRUCTOR_ROLE)
    return "Instructor not found" unless instructor

    if instructor.destroy
      instructor
    else
      instructor.errors.full_messages
    end
  end


  def create_student(params)
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password],
      role: STUDENT_ROLE,
      department_id: params[:department_id],
      semester_id: params[:semester_id]
    )
    if user.save
      user
    else
      user.errors.full_messages
    end
  end

  def create_student_record
    puts "Hello"
    student = Student.new(user_id: id, department_id: department_id, semester_id: semester_id)
    if student.save
      create_enrollment_record(student)
    else
      errors.add(:base, "Student record could not be created")
      raise ActiveRecord::Rollback
    end
  end

  def create_enrollment_record(student)

    puts "Here called : --- >"

    enrollment = Enrollment.new(
        student_id: student.user_id,
        semester_id: student.semester_id,
        status: "enrolled",
        enrolled_at: Time.now,
        started_at: nil,
        completed_at: nil
    )

    puts "#{enrollment.inspect}"
    if enrollment.save
      puts "Enrollment record created successfully: #{enrollment.inspect}"
    else
      errors.add(:base, "Enrollment record could not be created: #{enrollment.errors.full_messages.join(', ')}")
      raise ActiveRecord::Rollback
    end
  end

  def update_student(params)
    student = Student.find_by(user_id: id)
    return "Student not found" unless student

    if student.update(params)
      student
    else
      student.errors.full_messages
    end
  end

  def delete_student(params)
    student = User.find_by(id: params[:id], role: STUDENT_ROLE)
    return "Student not found" unless student

    if student.destroy
      student
    else
      student.errors.full_messages
    end
  end



  def instructor_role?
    role == INSTRUCTOR_ROLE
  end

  def student_role?
    role == STUDENT_ROLE
  end

  def admin_role?
    role == ADMIN_ROLE
  end

  def validate_password
    if password.present? && password.length < 6
      errors.add(:password, "Password must be at least 6 characters")
    end
  end

end

