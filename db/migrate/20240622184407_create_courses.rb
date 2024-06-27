class CreateCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :description
      t.integer :capacity
      t.boolean :self_enroll_allowed
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
