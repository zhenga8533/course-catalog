require "test_helper"

class StudentApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Assuming you have a fixture named `users` and `student_applications`
    @user = users(:user_one)
    @admin = users(:admin)
    @student_application = student_applications(:one)
    sign_in @user # Assuming Devise for authentication
  end

  test "should get index for admin" do
    sign_in @admin # Sign in as an admin
    get student_applications_url
    assert_response :success
    assert_select "h1", "Student Applications"
  end

  test "should get index for user" do
    sign_in @user # Sign in as a normal user
    get student_applications_url
    assert_response :success
    assert_select "h1", "Student Applications"
  end

  test "should show student application" do
    get student_application_url(@student_application)
    assert_response :success
  end

  test "should create student application" do
    assert_difference('StudentApplication.count') do
      post student_applications_url, params: { student_application: { contact_info: "123-456-7890", availability: '{"Monday": ["9am", "5pm"]}', preferences_in_grading_assignments: "Prefer grading essays", user_id: @user.id } }
    end
    assert_redirected_to student_application_path(StudentApplication.last)
    follow_redirect!
    assert_match "Student application was successfully created.", flash[:notice]
  end

  test "should get edit" do
    get edit_student_application_url(@student_application)
    assert_response :success
  end

  test "should update student application" do
    patch student_application_url(@student_application), params: { student_application: { contact_info: "Updated info", preferences_in_grading_assignments: "Updated preferences" } }
    assert_redirected_to student_application_path(@student_application)
    @student_application.reload
    assert_equal "Updated info", @student_application.contact_info
    assert_equal "Updated preferences", @student_application.preferences_in_grading_assignments
  end

  test "should destroy student application" do
    assert_difference('StudentApplication.count', -1) do
      delete student_application_url(@student_application)
    end
    assert_redirected_to student_applications_url
    assert_match "Student application was successfully destroyed.", flash[:notice]
  end

  private

  # Add helper method to sign in users for Devise (if using Devise)
  def sign_in(user)
    post user_session_path, params: { user: { email: user.email, password: 'testpassword' } }
  end
end
