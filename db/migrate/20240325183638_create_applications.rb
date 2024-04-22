class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.references :section, null: false, foreign_key: true 
      t.references :user, null: false, foreign_key: true 
      
      t.timestamps
    end
  end
end
