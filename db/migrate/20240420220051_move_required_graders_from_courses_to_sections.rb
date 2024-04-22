class MoveRequiredGradersFromCoursesToSections < ActiveRecord::Migration[7.1]
  def change
    remove_column :courses, :required_graders, :integer
    add_column :sections, :required_graders, :integer
  end
end
