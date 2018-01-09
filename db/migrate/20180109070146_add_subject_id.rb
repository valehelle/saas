class AddSubjectId < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :subject_id, :integer
  end
end
