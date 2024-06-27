class DropEnrollmentsTable < ActiveRecord::Migration[7.2]
  def change
    def up
      drop_table :enrollments
    end

    def down
      create_table :enrollments, id: :string do |t|
        t.string :student_id, null: false
        t.string :semester_id, null: false
        t.date :enrolled_at
        t.date :completed_at
        t.date :started_at
        t.string :status
        t.timestamps
      end

      add_index :enrollments, :semester_id
      add_index :enrollments, :student_id

      add_foreign_key :enrollments, :semesters
      add_foreign_key :enrollments, :users, column: :student_id
    end
  end
end
