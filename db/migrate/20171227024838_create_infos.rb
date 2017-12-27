class CreateInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :infos do |t|
      t.references :user, foreign_key: true
      t.boolean :is_teacher

      t.timestamps
    end
  end
end
