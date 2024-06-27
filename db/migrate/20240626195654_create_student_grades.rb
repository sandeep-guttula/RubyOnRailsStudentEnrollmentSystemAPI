class CreateStudentGrades < ActiveRecord::Migration[7.2]
  def change
    create_table :student_grades do |t|
      t.references :student, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.string :final_score

      t.timestamps
    end
  end
end
