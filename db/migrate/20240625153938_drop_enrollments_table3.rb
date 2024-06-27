class DropEnrollmentsTable3 < ActiveRecord::Migration[7.2]
  def change
    drop_table :enrollments , if_exists: true
  end
end
