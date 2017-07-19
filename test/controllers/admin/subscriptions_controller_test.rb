require 'test_helper'

class Admin::SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_subscription = admin_subscriptions(:one)
    @subscription_type  = admin_subscription_types(:subscription_type_one)
    @user = users(:one)
    Warden.test_mode!
    sign_in(@user)
  end

  teardown do
    Warden.test_reset!
  end

  test 'should get index' do
    get admin_subscriptions_url
    assert_response :success
  end

  test 'should get new' do
    get new_admin_subscription_url
    assert_response :success
  end

  test 'should create admin_subscription' do
    assert_difference('Admin::Subscription.count') do
      post admin_subscriptions_url, params: {
        admin_subscription: {
          duration: @admin_subscription.duration,
          end_date: @admin_subscription.end_date,
          start_date: @admin_subscription.start_date,
          subscription_type_id: @subscription_type.id,
          user_id: @admin_subscription.user_id
        }
      }
    end
    assert_redirected_to admin_subscription_url(Admin::Subscription.last, locale: 'da')
  end

  test 'should show admin_subscription' do
    get admin_subscription_url(@admin_subscription, locale: 'da')
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_subscription_url(@admin_subscription, locale: 'da')
    assert_response :success
  end
end
