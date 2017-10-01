require 'test_helper'

class Admin::VerticalMenuLinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_vertical_menu_link = admin_vertical_menu_links(:one)
  end

  test "should get index" do
    get admin_vertical_menu_links_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_vertical_menu_link_url
    assert_response :success
  end

  test "should create admin_vertical_menu_link" do
    assert_difference('Admin::VerticalMenuLink.count') do
      post admin_vertical_menu_links_url, params: { admin_vertical_menu_link: { active: @admin_vertical_menu_link.active, admin_vertical_menu_content_id: @admin_vertical_menu_link.admin_vertical_menu_content_id, background_color: @admin_vertical_menu_link.background_color, color: @admin_vertical_menu_link.color, page_id: @admin_vertical_menu_link.page_id, title: @admin_vertical_menu_link.title, url: @admin_vertical_menu_link.url } }
    end

    assert_redirected_to admin_vertical_menu_link_url(Admin::VerticalMenuLink.last)
  end

  test "should show admin_vertical_menu_link" do
    get admin_vertical_menu_link_url(@admin_vertical_menu_link)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_vertical_menu_link_url(@admin_vertical_menu_link)
    assert_response :success
  end

  test "should update admin_vertical_menu_link" do
    patch admin_vertical_menu_link_url(@admin_vertical_menu_link), params: { admin_vertical_menu_link: { active: @admin_vertical_menu_link.active, admin_vertical_menu_content_id: @admin_vertical_menu_link.admin_vertical_menu_content_id, background_color: @admin_vertical_menu_link.background_color, color: @admin_vertical_menu_link.color, page_id: @admin_vertical_menu_link.page_id, title: @admin_vertical_menu_link.title, url: @admin_vertical_menu_link.url } }
    assert_redirected_to admin_vertical_menu_link_url(@admin_vertical_menu_link)
  end

  test "should destroy admin_vertical_menu_link" do
    assert_difference('Admin::VerticalMenuLink.count', -1) do
      delete admin_vertical_menu_link_url(@admin_vertical_menu_link)
    end

    assert_redirected_to admin_vertical_menu_links_url
  end
end
