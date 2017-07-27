require 'test_helper'

class Admin::GalleryModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_gallery_module = admin_gallery_modules(:gallery_module_one)
    @page_module = page_modules(:gallery_module)
    @page        = @page_module.page
    @user = users(:one)
    Warden.test_mode!
    sign_in(@user)
  end

  teardown do
    Warden.test_reset!
  end

  test 'should get edit' do
    get edit_admin_page_gallery_module_url(@page, @admin_gallery_module, locale: 'da')
    assert_response :success
  end

  # test 'should get edit' do
  #   get edit_admin_gallery_module_url(@admin_gallery_module)
  #   assert_response :success
  # end

  test 'should update admin_gallery_module' do
    patch admin_page_gallery_module_url(@page, @admin_gallery_module, locale: 'da'), params: {
      admin_gallery_module: {
        body: @admin_gallery_module.body,
        layout: @admin_gallery_module.layout,
        name: @admin_gallery_module.name
      }
    }
    assert_redirected_to admin_page_url(@admin_gallery_module.page, locale: 'da')
  end

  test 'should destroy admin_gallery_module' do
    assert_difference('Admin::GalleryModule.count', -1) do
      delete admin_page_page_module_url(@page, @page_module, locale: 'da')
    end
    assert_redirected_to admin_page_url(@page, locale: 'da')
  end
end
