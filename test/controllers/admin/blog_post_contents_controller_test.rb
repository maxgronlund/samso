require 'test_helper'

class Admin::BlogPostContentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_blog_post_content = admin_blog_post_contents(:one)
  end

  test "should get index" do
    get admin_blog_post_contents_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_blog_post_content_url
    assert_response :success
  end

  test "should create admin_blog_post_content" do
    assert_difference('Admin::BlogPostContent.count') do
      post admin_blog_post_contents_url, params: { admin_blog_post_content: { admin_blog_post_id: @admin_blog_post_content.admin_blog_post_id, body: @admin_blog_post_content.body, image: @admin_blog_post_content.image, image_caption: @admin_blog_post_content.image_caption, position: @admin_blog_post_content.position, title: @admin_blog_post_content.title } }
    end

    assert_redirected_to admin_blog_post_content_url(Admin::BlogPostContent.last)
  end

  test "should show admin_blog_post_content" do
    get admin_blog_post_content_url(@admin_blog_post_content)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_blog_post_content_url(@admin_blog_post_content)
    assert_response :success
  end

  test "should update admin_blog_post_content" do
    patch admin_blog_post_content_url(@admin_blog_post_content), params: { admin_blog_post_content: { admin_blog_post_id: @admin_blog_post_content.admin_blog_post_id, body: @admin_blog_post_content.body, image: @admin_blog_post_content.image, image_caption: @admin_blog_post_content.image_caption, position: @admin_blog_post_content.position, title: @admin_blog_post_content.title } }
    assert_redirected_to admin_blog_post_content_url(@admin_blog_post_content)
  end

  test "should destroy admin_blog_post_content" do
    assert_difference('Admin::BlogPostContent.count', -1) do
      delete admin_blog_post_content_url(@admin_blog_post_content)
    end

    assert_redirected_to admin_blog_post_contents_url
  end
end
