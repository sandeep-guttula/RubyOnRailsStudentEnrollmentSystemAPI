class CreateEnrollments < ActiveRecord::Migration[7.2]
  def change
    create_table :enrollments, id: :string do |t|
      t.string :student_id, null: false
      t.string :semester_id, null: false
      t.date :enrolled_at
      t.date :completed_at
      t.date :started_at
      t.string :status

      t.timestamps
    end

    add_foreign_key :enrollments, :users, column: :student_id, primary_key: :id
    add_foreign_key :enrollments, :semesters, column: :semester_id, primary_key: :id
    add_index :enrollments, :student_id
    add_index :enrollments, :semester_id
  end
end
