require "test_helper"

class PieceImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get piece_images_create_url
    assert_response :success
  end

  test "should get destroy" do
    get piece_images_destroy_url
    assert_response :success
  end
end
