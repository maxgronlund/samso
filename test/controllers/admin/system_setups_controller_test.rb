require 'test_helper'

class Admin::SystemSetupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_system_setup = admin_system_setups(:one)
  end

  # test "should get index" do
  #   get admin_system_setups_url
  #   assert_response :success
  # end
  #
  # test "should get new" do
  #   get new_admin_system_setup_url
  #   assert_response :success
  # end
  #
  # test "should create admin_system_setup" do
  #   assert_difference('Admin::SystemSetup.count') do
  #     post admin_system_setups_url, params: { admin_system_setup: { maintenance: @admin_system_setup.maintenance } }
  #   end
  #
  #   assert_redirected_to admin_system_setup_url(Admin::SystemSetup.last)
  # end
  #
  # test "should show admin_system_setup" do
  #   get admin_system_setup_url(@admin_system_setup)
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get edit_admin_system_setup_url(@admin_system_setup)
  #   assert_response :success
  # end
  #
  # test "should update admin_system_setup" do
  #   patch admin_system_setup_url(@admin_system_setup), params: { admin_system_setup: { maintenance: @admin_system_setup.maintenance } }
  #   assert_redirected_to admin_system_setup_url(@admin_system_setup)
  # end
  #
  # test "should destroy admin_system_setup" do
  #   assert_difference('Admin::SystemSetup.count', -1) do
  #     delete admin_system_setup_url(@admin_system_setup)
  #   end
  #
  #   assert_redirected_to admin_system_setups_url
  # end
end
