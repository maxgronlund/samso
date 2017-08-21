require 'test_helper'

class Admin::SubscriptionModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_subscription_module = admin_subscription_modules(:subscription_module_one)
    @admin_page_module = page_modules(:three)
    @page = pages(:subscription_page)
    @user = users(:one)
  end

  test 'should get edit' do
    get edit_admin_page_subscription_module_url(@page, @admin_subscription_module, locale: 'da')
    assert_response :success
  end

  test 'should update admin_subscription_module' do
    patch admin_page_subscription_module_url(@page, @admin_subscription_module, locale: 'da'), params: {
      admin_subscription_module: {
        body: @admin_subscription_module.body,
        layout: @admin_subscription_module.layout,
        name: @admin_subscription_module.name
      }
    }
    assert_redirected_to admin_page_url(@admin_subscription_module.page, locale: 'da')
  end

  test 'should destroy admin_subscription_module' do
    assert_difference('Admin::SubscriptionModule.count', -1) do
      delete admin_page_page_module_url(@page, @admin_page_module, locale: 'da')
    end
    assert_redirected_to admin_page_url(@page, locale: 'da')
  end
end
