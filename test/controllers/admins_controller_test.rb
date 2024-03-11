require "test_helper"

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get unverified_users" do
    get admins_unverified_users_url
    assert_response :success
  end

  test "should get verify_user" do
    get admins_verify_user_url
    assert_response :success
  end
end
