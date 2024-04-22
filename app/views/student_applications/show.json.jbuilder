json.extract! @student_application, :id, :contact_info, :status
json.user_email @student_application.user.email
json.preferred_courses @student_application.courses, :id, :title 
