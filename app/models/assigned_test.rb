class AssignedTest < ApplicationRecord
  belongs_to :test
  belongs_to :student

  validates :test_id, presence: true
  validates :student_id, presence: true
end
