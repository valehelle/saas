class DropIsTeacher < ActiveRecord::Migration[5.1]
  def change
    remove_column :infos, :is_teacher
  end
end
