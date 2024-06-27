class CreateGrades < ActiveRecord::Migration[7.2]
  def change
    create_table :grades do |t|
      t.string :grade
      t.integer :start_from
      t.integer :ends_at

      t.timestamps
    end
  end
end
