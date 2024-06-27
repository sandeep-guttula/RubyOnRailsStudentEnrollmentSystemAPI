class RemoveInstructorIdFromCourseOfferings < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :course_offerings, :users, column: :instructor_id
    remove_column :course_offerings, :instructor_id, :integer
  end
end
