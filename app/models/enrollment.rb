class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :semester
  belongs_to :course_offering
  has_one :course, through: :course_offering

  validates :student_id, presence: true
  validates :course_offering_id, presence: true
  validates :grade, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  validates :grade, presence: true, if: :finalized?

end


