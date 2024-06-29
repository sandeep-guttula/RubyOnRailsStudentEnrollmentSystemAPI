class AssignedTest < ApplicationRecord
  belongs_to :test
  belongs_to :student, class_name: "User", foreign_key: :student_id

  def update_score(test, student, course, score)

    assigned_test = AssignedTest.find_by(test_id: test.id, student_id: student.user_id)
    error!({ error: "Student has not attempted this test" }, 400) unless assigned_test.is_attempted

    assigned_test.update!(score: score)
    tests = course.tests
    scored_tests = tests.select { |test| test.assigned_tests.where(student_id: student.user_id).first.score.present? }
    if tests.count == scored_tests.count
      total_score = 0
      scored_tests.each do |test|
        total_score += test.assigned_tests.where(student_id: student.user_id).first.score
      end
      average_score = total_score / tests.count
      StudentGrade.create!(student_id: student.user_id, course_id: course.id, final_score: average_score)
    end
    assigned_test
  end
end


