require "test_helper"

class SectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sections_new_url
    assert_response :success
  end

  test "should get create" do
    get sections_create_url
    assert_response :success
  end
end
