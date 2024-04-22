class CreateRecommendations < ActiveRecord::Migration[7.1]
  def change
    create_table :recommendations do |t|
      t.string :student_email
      t.string :prof_email
      t.references :section, null: false, foreign_key: true

      t.timestamps
    end
  end
end
