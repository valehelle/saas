class DropTeacherColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :subjects, :teacher_id
  end
end
