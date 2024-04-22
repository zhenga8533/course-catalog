class RemoveAvailabilityFromStudentApplications < ActiveRecord::Migration[6.0]
  def change
    remove_column :student_applications, :availability
  end
end
