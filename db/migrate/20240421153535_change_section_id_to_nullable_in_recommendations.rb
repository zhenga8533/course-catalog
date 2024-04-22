class ChangeSectionIdToNullableInRecommendations < ActiveRecord::Migration[7.1]
  def change
    change_column_null :recommendations, :section_id, true
  end
end
