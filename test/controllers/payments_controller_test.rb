require 'test_helper'

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payment = payments(:one)
    @user = users(:one)
    Warden.test_mode!
    sign_in(@user)
    @subscription_type  = admin_subscription_types(:subscription_type_one)
    @subscription       = admin_subscriptions(:one)
    @admin_system_setup = admin_system_setups(:one)
  end

  teardown do
    Warden.test_reset!
  end

  test 'should get index' do
    get payments_url
    assert_response :success
  end

  # test 'should get new' do
  #   get new_payment_url
  #   assert_response :success
  # end

  # test 'should create payment' do
  #   assert_difference('Payment.count') do
  #     post payments_url(locale: 'da'), params: {
  #       payment: {
  #         address: @payment.address,
  #         email: @payment.email,
  #         name: @payment.name,
  #         news_letter: @payment.news_letter,
  #         password: @payment.password,
  #         password_confirmation: @payment.password_confirmation,
  #         postal_code_and_city: @payment.postal_code_and_city,
  #         subscription_id: @subscription.id,
  #         user_id: @payment.user_id
  #       }
  #     }
  #   end
  #   assert_redirected_to payment_url(Payment.last)
  # end
  #
  # test 'should show payment' do
  #   get payment_url(@payment, locale: 'da')
  #   assert_response :success
  # end
  #
  # test 'should get edit' do
  #   get edit_payment_url(@payment, locale: 'da')
  #   assert_response :success
  # end
  #
  # test 'should update payment' do
  #   patch payment_url(@payment, locale: 'da'), params: {
  #     payment: {
  #       address: @payment.address,
  #       email: @payment.email,
  #       name: @payment.name,
  #       news_letter: @payment.news_letter,
  #       password: @payment.password,
  #       password_confirmation: @payment.password_confirmation,
  #       postal_code_and_city: @payment.postal_code_and_city,
  #       subscription_id: @payment.subscription_id,
  #       user_id: @payment.user_id
  #     }
  #   }
  #   assert_redirected_to payment_url(@payment, locale: 'da')
  # end
end
