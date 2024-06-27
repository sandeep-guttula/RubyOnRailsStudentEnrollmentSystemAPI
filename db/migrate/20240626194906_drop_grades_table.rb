class DropGradesTable < ActiveRecord::Migration[7.2]
  def change
    drop_table :grades
  end
end
