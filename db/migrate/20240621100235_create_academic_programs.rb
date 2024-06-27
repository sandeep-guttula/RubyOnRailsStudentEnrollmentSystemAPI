class CreateAcademicPrograms < ActiveRecord::Migration[7.2]
  def change
    create_table :academic_programs do |t|
      t.string :name
      t.integer :semester_count

      t.timestamps
    end
  end
end
