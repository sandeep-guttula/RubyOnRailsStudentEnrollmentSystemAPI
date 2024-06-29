class UpdateForeignKeys < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :student_grades, :students
    remove_foreign_key :course_instructors, :instructors

    add_foreign_key :student_grades, :users, column: :student_id
    add_foreign_key :course_instructors, :users, column: :instructor_id
  end
end
