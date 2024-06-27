class DropEnrollmentsTable2 < ActiveRecord::Migration[7.2]
  def change
    def up
      drop_table :enrollments
    end
  end
end
