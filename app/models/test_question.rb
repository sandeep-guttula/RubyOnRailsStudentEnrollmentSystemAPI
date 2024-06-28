class TestQuestion < ApplicationRecord
  belongs_to :test
  has_many :student_answers, dependent: :destroy

  def create_question(test_id, question, course_id)

    test = Test.find_by(id: test_id)
    return { error: "Test not found" } unless test

    if test.course_id != course_id
      return { error: "Test does not belong to the course" }
    end

    test_question = TestQuestion.new(test_id: test_id, question: question)
    if test_question.save
      test_question
    else
      test_question.errors
    end
  end

  def update_question(question_id)
    question = TestQuestion.find_by(id: question_id)
    return { error: "Question not found" } unless question

    if question.update(question: question)
      question
    else
      question.errors
    end
  end

  def delete_question(question_id)
    question = TestQuestion.find_by(id: question_id)
    return { error: "Question not found" } unless question

    if question.destroy
      { message: "Question deleted successfully" }
    else
      question.errors
    end
  end

end
