require 'test_helper'

class Admin::VerticalMenuContentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_vertical_menu_content = admin_vertical_menu_contents(:one)
  end

  test 'should get index' do
    get admin_vertical_menu_contents_url
    assert_response :success
  end

  test 'should get new' do
    get new_admin_vertical_menu_content_url
    assert_response :success
  end

  test 'should create admin_vertical_menu_content' do
    assert_difference('Admin::VerticalMenuContent.count') do
      post admin_vertical_menu_contents_url, params: { admin_vertical_menu_content: { name: @admin_vertical_menu_content.name } }
    end

    assert_redirected_to admin_vertical_menu_content_url(Admin::VerticalMenuContent.last)
  end

  test 'should show admin_vertical_menu_content' do
    get admin_vertical_menu_content_url(@admin_vertical_menu_content)
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_vertical_menu_content_url(@admin_vertical_menu_content)
    assert_response :success
  end

  test 'should update admin_vertical_menu_content' do
    patch(
      admin_vertical_menu_content_url(@admin_vertical_menu_content),
      params: {
        admin_vertical_menu_content: { name: @admin_vertical_menu_content.name }
      }
    )
    assert_redirected_to admin_vertical_menu_content_url(@admin_vertical_menu_content)
  end

  test 'should destroy admin_vertical_menu_content' do
    assert_difference('Admin::VerticalMenuContent.count', -1) do
      delete admin_vertical_menu_content_url(@admin_vertical_menu_content)
    end

    assert_redirected_to admin_vertical_menu_contents_url
  end
end
