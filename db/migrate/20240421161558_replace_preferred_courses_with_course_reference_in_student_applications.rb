class ReplacePreferredCoursesWithCourseReferenceInStudentApplications < ActiveRecord::Migration[7.1]
  def change
    add_reference :student_applications, :course, foreign_key: true
  end
end
