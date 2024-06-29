class Test < ApplicationRecord
  belongs_to :course
  belongs_to :semester
  belongs_to :instructor, class_name: "User", foreign_key: "instructor_id"
  has_many :assigned_tests, dependent: :destroy
  has_many :students, through: :assigned_tests
  has_many :test_questions, dependent: :destroy

  validates :name, presence: true
  validates :max_score, presence: true, numericality: { only_integer: true }
  validates :course_id, presence: true
  validates :semester_id, presence: true
  validates :instructor_id, presence: true

  def create_test(params)

    if Current.user.role == "instructor"
      semester = Semester.find_by(id: params[:semester_id])
      errors.add(:semester_id, "Semester not found") unless semester

      course = Course.find_by(id: params[:course_id])
      errors.add(:course_id, "Course not found") unless course

      if Instructor.find_by(user_id: Current.user.id).department_id != course.department_id
        return { error: "You are not authorized to create test" }
      end


      test = Test.new(params.merge(instructor_id: Current.user.id))
      if test.save
        test.assign_test_to_students
        test
      else
        test.errors
      end
    else
      errors.add("You are not authorized to create test")
    end
  end

  def assign_test_to_students
    students = Semester.find(self.semester_id).students
    students.each do |student|
      begin
        self.assigned_tests.create!(student_id: student.user_id, is_attempted: false)
      rescue ActiveRecord::RecordInvalid => e
        puts "Failed to assign test to student #{student.user_id}: #{e.message} "
      end
    end
  end
end
