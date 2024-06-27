class Semester < ApplicationRecord
  belongs_to :academic_program
  has_many :course_offerings
  has_many :courses, through: :course_offerings
  has_many :students
  has_many :enrollments
  has_many :tests

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :academic_program_id, presence: true
end
