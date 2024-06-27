class CreateEnrollments1 < ActiveRecord::Migration[7.2]
  def change
    create_table :enrollments do |t|
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :semester, null: false, foreign_key: true
      t.string :status
      t.datetime :enrolled_at
      t.datetime :started_at
      t.datetime :completed_at

      t.timestamps
    end
  end
end
