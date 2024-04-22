json.array! @student_applications do |application|
  json.extract! application, :id, :contact_info, :status
  json.user_email application.user.email
  json.preferred_courses application.courses, :id, :title  # Changed :name to :title
end
