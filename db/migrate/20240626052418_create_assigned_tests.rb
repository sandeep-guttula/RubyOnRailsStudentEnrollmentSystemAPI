class CreateAssignedTests < ActiveRecord::Migration[7.2]
  def change
    create_table :assigned_tests do |t|
      t.references :test, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.boolean :is_attempted, default: false

      t.timestamps
    end

    add_index :assigned_tests, [:test_id, :student_id], unique: true
  end
end
