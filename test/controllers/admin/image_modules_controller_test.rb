require 'test_helper'

class Admin::ImageModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_image_module = admin_image_modules(:image_module_one)
    @page_module = page_modules(:image_module)
    @page        = @page_module.page
    @user = users(:one)
  end

  test 'should get edit' do
    get edit_admin_page_image_module_url(@page, @admin_image_module, locale: 'da')
    assert_response :success
  end

  test 'should update admin_image_module' do
    patch admin_page_image_module_url(@page, @admin_image_module, locale: 'da'), params: {
      admin_image_module: {
        layout: @admin_image_module.layout
      }
    }
    assert_redirected_to admin_page_url(@admin_image_module.page, locale: 'da')
  end

  test 'should destroy admin_image_module' do
    assert_difference('Admin::ImageModule.count', -1) do
      delete admin_page_page_module_url(@page, @page_module, locale: 'da')
    end
    assert_redirected_to admin_page_url(@page, locale: 'da')
  end
end
