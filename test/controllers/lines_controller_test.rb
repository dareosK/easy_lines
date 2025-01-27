require "test_helper"

class LinesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get lines_create_url
    assert_response :success
  end

  test "should get destroy" do
    get lines_destroy_url
    assert_response :success
  end
end
