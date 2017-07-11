require 'test_helper'

class Admin::SubscriptionModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_subscription_module = admin_subscription_modules(:one)
  end

  test "should get index" do
    get admin_subscription_modules_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_subscription_module_url
    assert_response :success
  end

  test "should create admin_subscription_module" do
    assert_difference('Admin::SubscriptionModule.count') do
      post admin_subscription_modules_url, params: { admin_subscription_module: { body: @admin_subscription_module.body, layout: @admin_subscription_module.layout, name: @admin_subscription_module.name } }
    end

    assert_redirected_to admin_subscription_module_url(Admin::SubscriptionModule.last)
  end

  test "should show admin_subscription_module" do
    get admin_subscription_module_url(@admin_subscription_module)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_subscription_module_url(@admin_subscription_module)
    assert_response :success
  end

  test "should update admin_subscription_module" do
    patch admin_subscription_module_url(@admin_subscription_module), params: { admin_subscription_module: { body: @admin_subscription_module.body, layout: @admin_subscription_module.layout, name: @admin_subscription_module.name } }
    assert_redirected_to admin_subscription_module_url(@admin_subscription_module)
  end

  test "should destroy admin_subscription_module" do
    assert_difference('Admin::SubscriptionModule.count', -1) do
      delete admin_subscription_module_url(@admin_subscription_module)
    end

    assert_redirected_to admin_subscription_modules_url
  end
end
