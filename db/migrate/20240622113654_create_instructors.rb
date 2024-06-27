class CreateInstructors < ActiveRecord::Migration[7.2]
  def change
    create_table :instructors do |t|
      t.references :user, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.integer :year_of_exp

      t.timestamps
    end
  end
end
