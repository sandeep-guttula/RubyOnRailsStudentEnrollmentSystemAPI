class AddDepartmentIdToCourseOfferings < ActiveRecord::Migration[7.2]
  def change
    add_column :course_offerings, :department_id, :integer
  end
end
