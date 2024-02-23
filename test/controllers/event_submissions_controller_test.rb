require "test_helper"

class EventSubmissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get event_submissions_index_url
    assert_response :success
  end

  test "should get show" do
    get event_submissions_show_url
    assert_response :success
  end

  test "should get edit" do
    get event_submissions_edit_url
    assert_response :success
  end

  test "should get update" do
    get event_submissions_update_url
    assert_response :success
  end
end
