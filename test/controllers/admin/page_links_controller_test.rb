require 'test_helper'

class Admin::PageLinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_page_link = admin_page_links(:one)
  end

  test "should get index" do
    get admin_page_links_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_page_link_url
    assert_response :success
  end

  test "should create admin_page_link" do
    assert_difference('Admin::PageLink.count') do
      post admin_page_links_url, params: { admin_page_link: { background_color: @admin_page_link.background_color, color: @admin_page_link.color, name: @admin_page_link.name, page_id: @admin_page_link.page_id } }
    end

    assert_redirected_to admin_page_link_url(Admin::PageLink.last)
  end

  test "should show admin_page_link" do
    get admin_page_link_url(@admin_page_link)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_page_link_url(@admin_page_link)
    assert_response :success
  end

  test "should update admin_page_link" do
    patch admin_page_link_url(@admin_page_link), params: { admin_page_link: { background_color: @admin_page_link.background_color, color: @admin_page_link.color, name: @admin_page_link.name, page_id: @admin_page_link.page_id } }
    assert_redirected_to admin_page_link_url(@admin_page_link)
  end

  test "should destroy admin_page_link" do
    assert_difference('Admin::PageLink.count', -1) do
      delete admin_page_link_url(@admin_page_link)
    end

    assert_redirected_to admin_page_links_url
  end
end
