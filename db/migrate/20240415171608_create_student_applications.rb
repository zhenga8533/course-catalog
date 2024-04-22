class CreateStudentApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :student_applications do |t|
      t.references :user, null: false, foreign_key: true
      t.json :availability, default: {}.to_json, null: false # Change to json
      t.string :status, default: "pending", null: false
      t.text :notes

      t.timestamps
    end
    add_index :student_applications, :status
  end
end
