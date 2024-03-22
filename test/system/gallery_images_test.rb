require "application_system_test_case"

class GalleryImagesTest < ApplicationSystemTestCase
  setup do
    @gallery_image = gallery_images(:one)
  end

  test "visiting the index" do
    visit gallery_images_url
    assert_selector "h1", text: "Gallery images"
  end

  test "should create gallery image" do
    visit gallery_images_url
    click_on "New gallery image"

    fill_in "Gallery", with: @gallery_image.gallery_id
    fill_in "Image", with: @gallery_image.image
    fill_in "Position", with: @gallery_image.position
    click_on "Create Gallery image"

    assert_text "Gallery image was successfully created"
    click_on "Back"
  end

  test "should update Gallery image" do
    visit gallery_image_url(@gallery_image)
    click_on "Edit this gallery image", match: :first

    fill_in "Gallery", with: @gallery_image.gallery_id
    fill_in "Image", with: @gallery_image.image
    fill_in "Position", with: @gallery_image.position
    click_on "Update Gallery image"

    assert_text "Gallery image was successfully updated"
    click_on "Back"
  end

  test "should destroy Gallery image" do
    visit gallery_image_url(@gallery_image)
    click_on "Destroy this gallery image", match: :first

    assert_text "Gallery image was successfully destroyed"
  end
end
