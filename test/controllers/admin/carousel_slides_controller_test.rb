require 'test_helper'

class Admin::CarouselSlidesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_carousel_slide = admin_carousel_slides(:slide_one)
    @carousel_module      = admin_carousel_modules(:carousel_one)
    @user = users(:one)
  end

  test 'should get new' do
    get new_admin_carousel_module_carousel_slide_url(@carousel_module.id, locale: 'da')
    assert_response :success
  end

  # test 'should create admin_carousel_slide' do
  #   assert_difference('Admin::CarouselSlide.count') do
  #     post admin_carousel_module_carousel_slide_url(params: {
  #       admin_carousel_slide: {
  #         carousel_module_id: @carousel_module.id,
  #         title: @admin_carousel_slide.title,
  #         body: @admin_carousel_slide.body,
  #         position: @admin_carousel_slide.position,
  #         image: 'fo'
  #         }
  #     }, locale: 'da')
  #   end
  #
  #   assert_redirected_to admin_carousel_slide_url(Admin::CarouselSlide.last)
  # end

  test 'should get edit' do
    get edit_admin_carousel_module_carousel_slide_url(@carousel_module, @admin_carousel_slide, locale: 'da')
    assert_response :success
  end

  # test 'should update admin_carousel_slide' do
  #   patch admin_carousel_module_carousel_slide_url(@carousel_module, @admin_carousel_slide, locale: 'da'), params: {
  #     admin_carousel_slide: {
  #       admin_carousel_module_id: @admin_carousel_slide.carousel_module_id,
  #       body: @admin_carousel_slide.body,
  #       position: @admin_carousel_slide.position,
  #       title: @admin_carousel_slide.title,
  #     }
  #   }
  #   assert_redirected_to admin_carousel_slide_url(@admin_carousel_slide)
  # end
end
