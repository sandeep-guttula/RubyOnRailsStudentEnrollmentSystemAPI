class AddScoreToAssignedTests < ActiveRecord::Migration[7.2]
  def change
    add_column :assigned_tests, :score, :integer
  end
end
