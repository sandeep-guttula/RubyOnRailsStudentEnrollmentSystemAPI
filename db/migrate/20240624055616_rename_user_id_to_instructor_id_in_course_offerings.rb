class RenameUserIdToInstructorIdInCourseOfferings < ActiveRecord::Migration[7.2]
  def change
    rename_column :course_offerings, :user_id, :instructor_id

    # Update the foreign key
    remove_foreign_key :course_offerings, :users
    add_foreign_key :course_offerings, :users, column: :instructor_id

    # Update the index
    rename_index :course_offerings, 'index_course_offerings_on_user_id', 'index_course_offerings_on_instructor_id'
  end
end
