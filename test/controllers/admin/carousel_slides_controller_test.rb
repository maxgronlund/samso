require 'test_helper'

class Admin::CarouselSlidesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_carousel_slide = admin_carousel_slides(:one)
  end

  test "should get index" do
    get admin_carousel_slides_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_carousel_slide_url
    assert_response :success
  end

  test "should create admin_carousel_slide" do
    assert_difference('Admin::CarouselSlide.count') do
      post admin_carousel_slides_url, params: { admin_carousel_slide: { admin_carousel_module_id: @admin_carousel_slide.admin_carousel_module_id, body: @admin_carousel_slide.body, position: @admin_carousel_slide.position, title: @admin_carousel_slide.title } }
    end

    assert_redirected_to admin_carousel_slide_url(Admin::CarouselSlide.last)
  end

  test "should show admin_carousel_slide" do
    get admin_carousel_slide_url(@admin_carousel_slide)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_carousel_slide_url(@admin_carousel_slide)
    assert_response :success
  end

  test "should update admin_carousel_slide" do
    patch admin_carousel_slide_url(@admin_carousel_slide), params: { admin_carousel_slide: { admin_carousel_module_id: @admin_carousel_slide.admin_carousel_module_id, body: @admin_carousel_slide.body, position: @admin_carousel_slide.position, title: @admin_carousel_slide.title } }
    assert_redirected_to admin_carousel_slide_url(@admin_carousel_slide)
  end

  test "should destroy admin_carousel_slide" do
    assert_difference('Admin::CarouselSlide.count', -1) do
      delete admin_carousel_slide_url(@admin_carousel_slide)
    end

    assert_redirected_to admin_carousel_slides_url
  end
end
