class StudentAnswer < ApplicationRecord
  belongs_to :test_question
  belongs_to :student, class_name: "Student", foreign_key: :student_id
end
