require "test_helper"

class GalleryImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gallery_image = gallery_images(:one)
  end

  test "should get index" do
    get gallery_images_url
    assert_response :success
  end

  test "should get new" do
    get new_gallery_image_url
    assert_response :success
  end

  test "should create gallery_image" do
    assert_difference("GalleryImage.count") do
      post gallery_images_url, params: { gallery_image: { gallery_id: @gallery_image.gallery_id, image: @gallery_image.image, position: @gallery_image.position } }
    end

    assert_redirected_to gallery_image_url(GalleryImage.last)
  end

  test "should show gallery_image" do
    get gallery_image_url(@gallery_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_gallery_image_url(@gallery_image)
    assert_response :success
  end

  test "should update gallery_image" do
    patch gallery_image_url(@gallery_image), params: { gallery_image: { gallery_id: @gallery_image.gallery_id, image: @gallery_image.image, position: @gallery_image.position } }
    assert_redirected_to gallery_image_url(@gallery_image)
  end

  test "should destroy gallery_image" do
    assert_difference("GalleryImage.count", -1) do
      delete gallery_image_url(@gallery_image)
    end

    assert_redirected_to gallery_images_url
  end
end
