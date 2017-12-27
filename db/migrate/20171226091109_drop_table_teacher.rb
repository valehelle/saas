class DropTableTeacher < ActiveRecord::Migration[5.1]
  def change
    drop_table :teachers
  end
end
