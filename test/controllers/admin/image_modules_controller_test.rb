require 'test_helper'

class Admin::ImageModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_image_module = admin_image_modules(:one)
  end

  test "should get index" do
    get admin_image_modules_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_image_module_url
    assert_response :success
  end

  test "should create admin_image_module" do
    assert_difference('Admin::ImageModule.count') do
      post admin_image_modules_url, params: { admin_image_module: { layout: @admin_image_module.layout } }
    end

    assert_redirected_to admin_image_module_url(Admin::ImageModule.last)
  end

  test "should show admin_image_module" do
    get admin_image_module_url(@admin_image_module)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_image_module_url(@admin_image_module)
    assert_response :success
  end

  test "should update admin_image_module" do
    patch admin_image_module_url(@admin_image_module), params: { admin_image_module: { layout: @admin_image_module.layout } }
    assert_redirected_to admin_image_module_url(@admin_image_module)
  end

  test "should destroy admin_image_module" do
    assert_difference('Admin::ImageModule.count', -1) do
      delete admin_image_module_url(@admin_image_module)
    end

    assert_redirected_to admin_image_modules_url
  end
end
