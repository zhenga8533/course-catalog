class AddCourseToRecommendations < ActiveRecord::Migration[7.1]
  def change
    add_reference :recommendations, :course, null: false, foreign_key: true
  end
end
