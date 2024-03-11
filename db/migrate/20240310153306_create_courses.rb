class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :term
      t.string :title
      t.string :description
      t.string :subject
      t.integer :catalog_number
      t.string :campus
      t.integer :course_id
      t.integer :required_graders

      t.timestamps
    end
  end
end
