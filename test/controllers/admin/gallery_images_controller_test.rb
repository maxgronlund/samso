require 'test_helper'

class Admin::GalleryImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_gallery_image = admin_gallery_images(:one)
  end

  test "should get index" do
    get admin_gallery_images_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_gallery_image_url
    assert_response :success
  end

  test "should create admin_gallery_image" do
    assert_difference('Admin::GalleryImage.count') do
      post admin_gallery_images_url, params: { admin_gallery_image: { admin/gallery_module_id: @admin_gallery_image.admin/gallery_module_id, body: @admin_gallery_image.body, title: @admin_gallery_image.title, user_id: @admin_gallery_image.user_id } }
    end

    assert_redirected_to admin_gallery_image_url(Admin::GalleryImage.last)
  end

  test "should show admin_gallery_image" do
    get admin_gallery_image_url(@admin_gallery_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_gallery_image_url(@admin_gallery_image)
    assert_response :success
  end

  test "should update admin_gallery_image" do
    patch admin_gallery_image_url(@admin_gallery_image), params: { admin_gallery_image: { admin/gallery_module_id: @admin_gallery_image.admin/gallery_module_id, body: @admin_gallery_image.body, title: @admin_gallery_image.title, user_id: @admin_gallery_image.user_id } }
    assert_redirected_to admin_gallery_image_url(@admin_gallery_image)
  end

  test "should destroy admin_gallery_image" do
    assert_difference('Admin::GalleryImage.count', -1) do
      delete admin_gallery_image_url(@admin_gallery_image)
    end

    assert_redirected_to admin_gallery_images_url
  end
end
