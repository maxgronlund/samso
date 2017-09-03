# Translatede system messages
require 'test_helper'

class Admin::SystemMessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_system_message = admin_system_messages(:one)
  end

  test 'should get index' do
    get admin_system_messages_url
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_system_message_url(@admin_system_message, locale: I18n.locale)
    assert_response :success
  end

  test 'should update admin_system_message' do
    patch admin_system_message_url(@admin_system_message, locale: I18n.locale), params: {
      admin_system_message: {
        body: @admin_system_message.body,
        identifier: @admin_system_message.identifier,
        locale: @admin_system_message.locale,
        title: @admin_system_message.title
      }
    }
    assert_redirected_to admin_system_messages_url(locale: I18n.locale)
  end
end
