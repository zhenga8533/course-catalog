class AddReasonToRecommendations < ActiveRecord::Migration[7.1]
  def change
    add_column :recommendations, :reason, :text
  end
end
