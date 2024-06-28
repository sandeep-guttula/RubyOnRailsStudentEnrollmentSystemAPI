class Instructor < ApplicationRecord
  belongs_to :user
  belongs_to :department

  has_many :course_instructors
  has_many :courses, through: :course_instructors
  has_many :courses, through: :assigned_courses
  has_many :assigned_courses, foreign_key: :assigned_by_instructor_id

  validates :user_id, presence: true
  validates :department_id, presence: true
  validates :year_of_exp, presence: true

end
