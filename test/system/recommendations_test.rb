require "application_system_test_case"

class RecommendationsTest < ApplicationSystemTestCase
  setup do
    @recommendation = recommendations(:one)
  end

  test "visiting the index" do
    visit recommendations_url
    assert_selector "h1", text: "Recommendations"
  end

  test "should create recommendation" do
    visit recommendations_url
    click_on "New recommendation"

    fill_in "Prof email", with: @recommendation.prof_email
    fill_in "Section", with: @recommendation.section_id
    fill_in "Student email", with: @recommendation.student_email
    click_on "Create Recommendation"

    assert_text "Recommendation was successfully created"
    click_on "Back"
  end

  test "should update Recommendation" do
    visit recommendation_url(@recommendation)
    click_on "Edit this recommendation", match: :first

    fill_in "Prof email", with: @recommendation.prof_email
    fill_in "Section", with: @recommendation.section_id
    fill_in "Student email", with: @recommendation.student_email
    click_on "Update Recommendation"

    assert_text "Recommendation was successfully updated"
    click_on "Back"
  end

  test "should destroy Recommendation" do
    visit recommendation_url(@recommendation)
    click_on "Destroy this recommendation", match: :first

    assert_text "Recommendation was successfully destroyed"
  end
end
