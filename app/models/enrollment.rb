class Enrollment < ApplicationRecord

  belongs_to :user, foreign_key: :student_id
  belongs_to :semester

  has_many :assigned_courses
  has_many :courses, through: :assigned_courses

  validates :student_id, presence: true
  validates :semester_id, presence: true

end


