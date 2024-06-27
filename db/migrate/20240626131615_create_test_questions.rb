class CreateTestQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :test_questions do |t|
      t.references :test, null: false, foreign_key: true
      t.string :question

      t.timestamps
    end
  end
end
