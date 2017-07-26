require 'test_helper'

class Admin::GalleryModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_gallery_module = admin_gallery_modules(:one)
  end

  test "should get index" do
    get admin_gallery_modules_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_gallery_module_url
    assert_response :success
  end

  test "should create admin_gallery_module" do
    assert_difference('Admin::GalleryModule.count') do
      post admin_gallery_modules_url, params: { admin_gallery_module: { body: @admin_gallery_module.body, layout: @admin_gallery_module.layout, name: @admin_gallery_module.name } }
    end

    assert_redirected_to admin_gallery_module_url(Admin::GalleryModule.last)
  end

  test "should show admin_gallery_module" do
    get admin_gallery_module_url(@admin_gallery_module)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_gallery_module_url(@admin_gallery_module)
    assert_response :success
  end

  test "should update admin_gallery_module" do
    patch admin_gallery_module_url(@admin_gallery_module), params: { admin_gallery_module: { body: @admin_gallery_module.body, layout: @admin_gallery_module.layout, name: @admin_gallery_module.name } }
    assert_redirected_to admin_gallery_module_url(@admin_gallery_module)
  end

  test "should destroy admin_gallery_module" do
    assert_difference('Admin::GalleryModule.count', -1) do
      delete admin_gallery_module_url(@admin_gallery_module)
    end

    assert_redirected_to admin_gallery_modules_url
  end
end
