class CreateSections < ActiveRecord::Migration[7.1]
  def change
    create_table :sections do |t|
      t.integer :section_number
      t.string :component
      t.string :instruction_mode
      t.string :building_description
      t.string :start_time
      t.string :end_time
      t.string :start_date
      t.string :end_date
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday
      t.integer :course_id

      t.timestamps
    end
  end
end
