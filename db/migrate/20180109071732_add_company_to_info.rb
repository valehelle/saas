class AddCompanyToInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :infos, :company_id, :integer
  end
end
