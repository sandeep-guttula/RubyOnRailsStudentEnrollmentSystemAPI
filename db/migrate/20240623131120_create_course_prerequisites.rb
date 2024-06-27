class CreateCoursePrerequisites < ActiveRecord::Migration[7.2]
  def change
    create_table :course_prerequisites do |t|
      t.references :course, null: false, foreign_key: true
      t.references :prerequisite_course, null: false, foreign_key: { to_table: :courses }

      t.timestamps
    end
  end
end
