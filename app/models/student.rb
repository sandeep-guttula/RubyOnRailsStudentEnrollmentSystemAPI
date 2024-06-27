class Student < ApplicationRecord
  belongs_to :semester
  belongs_to :user
  belongs_to :department
  has_many :enrollments

  has_many :assigned_tests
  has_many :tests, through: :assigned_tests
  has_many :student_answers
end
