require 'test_helper'

class Admin::SubscriptionTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_subscription_type = admin_subscription_types(:subscription_type_one)
    @user = users(:one)
    Warden.test_mode!
    sign_in(@user)
  end

  teardown do
    Warden.test_reset!
  end

  test 'should get index' do
    get admin_subscription_types_url
    assert_response :success
  end

  test 'should get new' do
    get new_admin_subscription_type_url
    assert_response :success
  end

  test 'should create admin_subscription_type' do
    assert_difference('Admin::SubscriptionType.count') do
      post admin_subscription_types_url, params: {
        admin_subscription_type: {
          active: @admin_subscription_type.active,
          body: @admin_subscription_type.body,
          internet_version: @admin_subscription_type.internet_version,
          locale: @admin_subscription_type.locale,
          price: @admin_subscription_type.price,
          print_version: @admin_subscription_type.print_version,
          title: @admin_subscription_type.title
        }
      }
    end

    assert_redirected_to admin_subscription_type_url(Admin::SubscriptionType.last, locale: 'da')
  end

  test 'should show admin_subscription_type' do
    get admin_subscription_type_url(@admin_subscription_type, locale: 'da')
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_subscription_type_url(@admin_subscription_type, locale: 'da')
    assert_response :success
  end

  test 'should update admin_subscription_type' do
    patch admin_subscription_type_url(@admin_subscription_type, locale: 'da'), params: {
      admin_subscription_type: {
        active: @admin_subscription_type.active,
        body: @admin_subscription_type.body,
        internet_version: @admin_subscription_type.internet_version,
        locale: @admin_subscription_type.locale,
        price: @admin_subscription_type.price,
        print_version: @admin_subscription_type.print_version,
        title: @admin_subscription_type.title
      }
    }
    assert_redirected_to admin_subscription_type_url(@admin_subscription_type, locale: 'da')
  end

  test 'should destroy admin_subscription_type' do
    assert_difference('Admin::SubscriptionType.count', -1) do
      delete admin_subscription_type_url(@admin_subscription_type, locale: 'da')
    end

    assert_redirected_to admin_subscription_types_url(locale: 'da')
  end
end
