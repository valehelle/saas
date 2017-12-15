class CreateEnrolls < ActiveRecord::Migration[5.1]
  def change
    create_table :enrolls do |t|
      t.integer :student_id
      t.integer :subject_id

      t.timestamps
    end
  end
end
