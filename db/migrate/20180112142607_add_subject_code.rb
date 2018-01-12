class AddSubjectCode < ActiveRecord::Migration[5.1]
  def change
    add_column :subjects, :code, :string
  end
end
