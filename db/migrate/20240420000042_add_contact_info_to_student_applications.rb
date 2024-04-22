class AddContactInfoToStudentApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :student_applications, :contact_info, :string
  end
end
