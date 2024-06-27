class CreateAssignedCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :assigned_courses do |t|
      t.integer :student_id, null: false
      t.integer :course_id, null: false
      t.integer :assigned_by_instructor_id, null: false

      t.timestamps
    end

    add_foreign_key :assigned_courses, :users, column: :student_id
    add_foreign_key :assigned_courses, :courses, column: :course_id
    add_foreign_key :assigned_courses, :users, column: :assigned_by_instructor_id

    add_index :assigned_courses, :student_id
    add_index :assigned_courses, :course_id
    add_index :assigned_courses, :assigned_by_instructor_id
  end
end
