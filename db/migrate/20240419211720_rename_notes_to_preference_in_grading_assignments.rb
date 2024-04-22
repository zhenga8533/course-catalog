class RenameNotesToPreferenceInGradingAssignments < ActiveRecord::Migration[7.1]
  def change
    rename_column :student_applications, :notes, :preferences_in_grading_assignments
  end
end
