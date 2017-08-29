require 'test_helper'

class Admin::SystemMessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_system_message = admin_system_messages(:one)
  end

  test "should get index" do
    get admin_system_messages_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_system_message_url
    assert_response :success
  end

  test "should create admin_system_message" do
    assert_difference('Admin::SystemMessage.count') do
      post admin_system_messages_url, params: { admin_system_message: { body: @admin_system_message.body, identifier: @admin_system_message.identifier, locale: @admin_system_message.locale, title: @admin_system_message.title } }
    end

    assert_redirected_to admin_system_message_url(Admin::SystemMessage.last)
  end

  test "should show admin_system_message" do
    get admin_system_message_url(@admin_system_message)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_system_message_url(@admin_system_message)
    assert_response :success
  end

  test "should update admin_system_message" do
    patch admin_system_message_url(@admin_system_message), params: { admin_system_message: { body: @admin_system_message.body, identifier: @admin_system_message.identifier, locale: @admin_system_message.locale, title: @admin_system_message.title } }
    assert_redirected_to admin_system_message_url(@admin_system_message)
  end

  test "should destroy admin_system_message" do
    assert_difference('Admin::SystemMessage.count', -1) do
      delete admin_system_message_url(@admin_system_message)
    end

    assert_redirected_to admin_system_messages_url
  end
end
