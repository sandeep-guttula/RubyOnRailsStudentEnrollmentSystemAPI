class RemoveDepartmentIdFromCourseOfferings < ActiveRecord::Migration[7.2]
  def change
    remove_column :course_offerings, :department_id, :integer
  end
end
