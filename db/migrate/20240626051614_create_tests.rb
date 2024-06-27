class CreateTests < ActiveRecord::Migration[7.2]
  def change
    create_table :tests do |t|
      t.string :name
      t.string :description
      t.integer :course_id
      t.integer :semester_id
      t.integer :instructor_id
      t.integer :max_score

      t.timestamps
    end

    add_foreign_key :tests, :courses
    add_foreign_key :tests, :semesters
    add_foreign_key :tests, :users, column: :instructor_id

    add_index :tests, :course_id
    add_index :tests, :semester_id
    add_index :tests, :instructor_id
  end
end
