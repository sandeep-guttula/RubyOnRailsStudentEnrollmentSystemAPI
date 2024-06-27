class CourseOffering < ApplicationRecord
  belongs_to :course, foreign_key: :course_id
  belongs_to :semester, foreign_key: :semester_id
  belongs_to :department, foreign_key: :department_id
  has_many :enrollments

  validates :course_id, presence: true
  validates :semester_id, presence: true
  validates :department_id, presence: true

end
