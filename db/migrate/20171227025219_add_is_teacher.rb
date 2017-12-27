class AddIsTeacher < ActiveRecord::Migration[5.1]
  def change
    add_column :infos, :is_teacher, :boolean, default: false
  end
end
