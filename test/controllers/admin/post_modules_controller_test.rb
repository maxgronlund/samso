require 'test_helper'

class Admin::PostModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_post_module = admin_post_modules(:one)
  end

  test "should get index" do
    get admin_post_modules_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_post_module_url
    assert_response :success
  end

  test "should create admin_post_module" do
    assert_difference('Admin::PostModule.count') do
      post admin_post_modules_url, params: { admin_post_module: { name: @admin_post_module.name } }
    end

    assert_redirected_to admin_post_module_url(Admin::PostModule.last)
  end

  test "should show admin_post_module" do
    get admin_post_module_url(@admin_post_module)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_post_module_url(@admin_post_module)
    assert_response :success
  end

  test "should update admin_post_module" do
    patch admin_post_module_url(@admin_post_module), params: { admin_post_module: { name: @admin_post_module.name } }
    assert_redirected_to admin_post_module_url(@admin_post_module)
  end

  test "should destroy admin_post_module" do
    assert_difference('Admin::PostModule.count', -1) do
      delete admin_post_module_url(@admin_post_module)
    end

    assert_redirected_to admin_post_modules_url
  end
end
