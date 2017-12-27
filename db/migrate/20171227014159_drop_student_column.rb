class DropStudentColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :enrolls, :student_id
  end
end
