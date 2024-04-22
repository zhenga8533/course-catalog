class CreateJoinTableCourseStudentApplication < ActiveRecord::Migration[7.1]
  def change
    create_join_table :courses, :student_applications do |t|
      
    end
  end
end
