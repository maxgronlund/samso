require 'test_helper'

class Admin::PostModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_module = admin_post_modules(:post_module_one)
    @page = pages(:post_page)
    @user = users(:one)
    Warden.test_mode!
    sign_in(@user)
  end

  teardown do
    Warden.test_reset!
  end

  test 'should get edit' do
    get edit_admin_page_post_module_url(@page, @post_module, locale: 'da')
    assert_response :success
  end

  test 'should update admin_post_module' do
    patch admin_page_post_module_url(@page, @post_module, locale: 'da'), params: {
      admin_post_module: {
        name: @post_module.name
      }
    }
    assert_redirected_to admin_page_url(@post_module.page, locale: 'da')
  end

  test 'should destroy admin_post_module' do
    assert_difference('Admin::PostModule.count', -1) do
      delete admin_page_page_module_url(@page, @post_module.page_module, locale: 'da')
    end
    assert_redirected_to admin_page_url(@page, locale: 'da')
  end
end
