class AddCompanyId < ActiveRecord::Migration[5.1]
  def change
    add_column :subjects, :company_id, :integer
  end
end
