require 'test_helper'

class Admin::GalleryImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gallery_image  = admin_gallery_images(:gallery_image_one)
    @gallery_module = @gallery_image.gallery_module
    @page = @gallery_module.page
    @user = users(:one)
  end

  test 'should get new' do
    get new_gallery_module_gallery_image_url(@gallery_module, locale: 'da')
    assert_response :success
  end

  test 'should create admin_gallery_image' do
    assert_difference('Admin::GalleryImage.count') do
      post gallery_module_gallery_images_url(@gallery_module, locale: 'da'), params: {
        admin_gallery_image: {
          gallery_module_id: @gallery_image.gallery_module_id,
          body: @gallery_image.body,
          title: @gallery_image.title,
          user_id: @gallery_image.user_id
        }
      }
    end
    assert_redirected_to page_url(@page, locale: 'da')
  end

  test 'should get edit' do
    get edit_gallery_module_gallery_image_url(@gallery_module, @gallery_image, locale: 'da')
    assert_response :success
  end

  test 'should update admin_gallery_image' do
    patch gallery_module_gallery_image_url(@gallery_module, @gallery_image, locale: 'da'), params: {
      admin_gallery_image: {
        gallery_module_id: @gallery_image.gallery_module_id,
        body: @gallery_image.body,
        title: @gallery_image.title,
        user_id: @gallery_image.user_id
      }
    }
    assert_redirected_to page_url(@gallery_module.page)
  end

  # test 'should destroy admin_gallery_image' do
  #   assert_difference('Admin::GalleryImage.count', -1) do
  #     delete admin_gallery_image_url(@gallery_image)
  #   end
  #   assert_redirected_to admin_gallery_images_url
  # end

  test 'should destroy admin_gallery_image' do
    assert_difference('Admin::GalleryImage.count', -1) do
      delete gallery_module_gallery_image_url(@gallery_module, @gallery_image, locale: 'da')
    end
    assert_redirected_to page_url(@page, locale: 'da')
  end
end
