class RemoveCompanySubject < ActiveRecord::Migration[5.1]
  def change
    remove_column :companies, :subject_id
  end
end
