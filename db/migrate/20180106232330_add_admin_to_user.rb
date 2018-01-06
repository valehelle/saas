class AddAdminToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :infos, :is_admin, :boolean, default: false
  end
end
