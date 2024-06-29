class StudentAnswer < ApplicationRecord
  belongs_to :test_question
  belongs_to :student, class_name: "User", foreign_key: :student_id

  def create_answer(test, question, answer)

    test_question = test.test_questions.find_by(id: question)
    return { error: "Question not found" } unless test_question

    # check if the student is assigned tos the test
    if Current.user.id != test.students.find_by(id: Current.user.id).id
      error!({ error: "You are not authorized to answer this question" }, 401)
    end

    student_answer = StudentAnswer.new(answer: answer, test_question_id: test_question.id, student_id: Current.user.id)

    if student_answer.save
      AssignedTest.find_by(test_id: test.id, student_id: Current.user.id).update(is_attempted: true)
      student_answer
    else
      student_answer.errors
    end

  end
end
