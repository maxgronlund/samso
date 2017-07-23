require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_blog_post = admin_blog_posts(:blog_post_one)
    @admin_blog_module = admin_blog_modules(:blog_module_one)

    @user = users(:one)
    Warden.test_mode!
    sign_in(@user)
  end

  teardown do
    Warden.test_reset!
  end

  test 'should get new' do
    get new_blog_post_url(@admin_blog_module, locale: 'da')
    assert_response :success
  end

  test 'should create blog_post' do
    assert_difference('Admin::BlogPost.count') do
      post blog_posts_url(
        blog_id: @admin_blog_module.id,
        locale: 'da'
      ), params: {
        admin_blog_post: {
          body: @admin_blog_post.body,
          position: @admin_blog_post.position,
          title: @admin_blog_post.title
        }
      }
    end
    assert_redirected_to page_url(@admin_blog_module.page, locale: 'da')
  end
  #
  # test 'should show admin_blog_post' do
  #   get admin_blog_post_url(@admin_blog_post, locale: 'da')
  #   assert_response :success
  # end

  # test 'should get edit' do
  #   get edit_admin_blog_post_url(@admin_blog_post, locale: 'da')
  #   assert_response :success
  # end

  # test 'should update admin_blog_post' do
  #   patch admin_blog_post_url(@admin_blog_post, locale: 'da'), params: {
  #     admin_blog_post: {
  #       body: @admin_blog_post.body,
  #       position: @admin_blog_post.position,
  #       title: @admin_blog_post.title
  #     }
  #   }
  #   assert_redirected_to admin_blog_post_url(@admin_blog_post, locale: 'da')
  # end

  # test 'should destroy admin_blog_post' do
  #   assert_difference('Admin::BlogPost.count', -1) do
  #     delete post_url(@admin_blog_post)
  #   end
  #   assert_redirected_to page_url(locale: 'da')
  # end
end
