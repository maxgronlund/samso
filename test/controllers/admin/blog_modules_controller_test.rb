require 'test_helper'

class Admin::BlogModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_blog_module = admin_blog_modules(:blog_module_one)
    @admin_page_module = page_modules(:blog_page_module)
    @page = pages(:news_page)
    @user = users(:one)
    Warden.test_mode!
    sign_in(@user)
  end

  teardown do
    Warden.test_reset!
  end

  test 'should get edit' do
    get edit_admin_page_blog_module_url(@page, @admin_blog_module, locale: 'da')
    assert_response :success
  end

  test 'should update admin_blog_module' do
    patch admin_page_blog_module_url(@page, @admin_blog_module, locale: 'da'), params: {
      admin_blog_module:
      {
        body: @admin_blog_module.body,
        layout: 'elvis_presley',
        name: @admin_blog_module.name
      }
    }
    assert_redirected_to admin_page_url(@admin_blog_module.page, locale: 'da')
  end

  test 'should destroy admin_blog_module' do
    assert_difference('Admin::BlogModule.count', -1) do
      delete admin_page_page_module_url(@page, @admin_page_module, locale: 'da')
    end
    assert_redirected_to admin_page_url(@page, locale: 'da')
  end
end
