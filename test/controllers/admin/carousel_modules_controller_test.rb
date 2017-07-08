require 'test_helper'

class Admin::CarouselModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_carousel_module = admin_carousel_modules(:one)
    @page = pages(:one)
  end

  # test "should get index" do
  #   get admin_carousel_modules_url
  #   assert_response :success
  # end

  #  test "should get new" do
  #    get new_admin_carousel_module_url
  #    assert_response :success
  #  end

  # test "should create admin_carousel_module" do
  #   assert_difference('Admin::CarouselModule.count') do
  #     post admin_carousel_modules_url, params: {
  #       admin_carousel_module: {
  #         layout: @admin_carousel_module.layout,
  #         name: @admin_carousel_module.name
  #       }
  #     }
  #   end
  #
  #   assert_redirected_to admin_carousel_module_url(Admin::CarouselModule.last, locale: 'da')
  # end

  #  test "should show admin_carousel_module" do
  #    get admin_carousel_module_url(@admin_carousel_module)
  #    assert_response :success
  #  end

  #  test "should get edit" do
  #    get edit_admin_page_carousel_module_url(@page, @admin_carousel_module)
  #    #get edit_admin_carousel_module_url(@admin_carousel_module)
  #    assert_response :success
  #  end
  #
  #  test "should update admin_carousel_module" do
  #    patch admin_carousel_module_url(@page, @admin_carousel_module), params: {
  #      admin_carousel_module:
  #      {
  #        layout: @admin_carousel_module.layout,
  #        name: @admin_carousel_module.name
  #      }
  #    }
  #    assert_redirected_to admin_carousel_module_url(@admin_carousel_module, locale: 'da')
  #  end

  # test "should destroy admin_carousel_module" do
  #   assert_difference('Admin::CarouselModule.count', -1) do
  #     delete admin_page_page_module_url(page, carousel_module.page_module
  #     #delete admin_carousel_module_url(@admin_carousel_module)
  #   end
  #
  #   assert_redirected_to admin_carousel_modules_url(locale: 'da')
  # end
end
