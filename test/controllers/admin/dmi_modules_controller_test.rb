require 'test_helper'

class Admin::DmiModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_dmi_module = admin_dmi_modules(:one)
  end

  test "should get index" do
    get admin_dmi_modules_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_dmi_module_url
    assert_response :success
  end

  test "should create admin_dmi_module" do
    assert_difference('Admin::DmiModule.count') do
      post admin_dmi_modules_url, params: { admin_dmi_module: { forecast_duration: @admin_dmi_module.forecast_duration } }
    end

    assert_redirected_to admin_dmi_module_url(Admin::DmiModule.last)
  end

  test "should show admin_dmi_module" do
    get admin_dmi_module_url(@admin_dmi_module)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_dmi_module_url(@admin_dmi_module)
    assert_response :success
  end

  test "should update admin_dmi_module" do
    patch admin_dmi_module_url(@admin_dmi_module), params: { admin_dmi_module: { forecast_duration: @admin_dmi_module.forecast_duration } }
    assert_redirected_to admin_dmi_module_url(@admin_dmi_module)
  end

  test "should destroy admin_dmi_module" do
    assert_difference('Admin::DmiModule.count', -1) do
      delete admin_dmi_module_url(@admin_dmi_module)
    end

    assert_redirected_to admin_dmi_modules_url
  end
end
