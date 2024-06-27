class AddForeignKeyToCourseOfferings < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :course_offerings, :departments
  end
end
