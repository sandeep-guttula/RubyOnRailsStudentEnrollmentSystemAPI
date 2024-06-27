class CreateStudentAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :student_answers do |t|
      t.string :answer
      t.references :test_question, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
