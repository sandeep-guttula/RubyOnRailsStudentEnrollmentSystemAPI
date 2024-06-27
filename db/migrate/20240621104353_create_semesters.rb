class CreateSemesters < ActiveRecord::Migration[7.2]
  def change
    create_table :semesters do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.references :academic_program, null: false, foreign_key: true

      t.timestamps
    end
  end
end
