class AddTeacherToSubject < ActiveRecord::Migration[5.1]
  def change
    add_column :subjects, :teacher_id, :integer
  end
end
