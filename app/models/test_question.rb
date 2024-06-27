class TestQuestion < ApplicationRecord
  belongs_to :test
  has_many :student_answers, dependent: :destroy

  def create_question(test_id, question)


    puts "test_id: #{test_id} , question: #{question}"

    test = Test.find_by(id: test_id)
    return { error: "Test not found" } unless test

    test_question = TestQuestion.new(test_id: test_id, question: question)
    if test_question.save
      test_question
    else
      test_question.errors
    end
  end

end
