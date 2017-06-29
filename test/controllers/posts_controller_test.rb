require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @post = posts(:one)
    @system_setup = admin_system_setups(:one)
    sign_in users(:one)
  end

  test 'should get index' do
    get admin_posts_url(locale: 'da')
    assert_response :success
  end

  test 'should get new' do
    get new_admin_post_url(locale: 'da')
    assert_response :success
  end

  test 'should create post' do
    assert_difference('Post.count') do
      post admin_posts_url, params:
      {
        post: {
          body: @post.body,
          postable_id: @system_setup.id,
          postable_type: @system_setup.class.name,
          identifier: @post.identifier,
          position: @post.position,
          title: @post.title
        }
      }
    end
    assert_redirected_to admin_posts_url(locale: 'da')
  end

  test 'should show post' do
    get admin_posts_url(locale: 'da')
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_post_url(@post, locale: 'da')
    assert_response :success
  end

  test 'should update post' do
    patch admin_post_url(
      id: @post.id,
      locale: 'da',
      params: {
        post: {
          body: @post.body,
          postable: @system_setup,
          identifier: @post.identifier,
          position: @post.position,
          title: @post.title
        }
      }
    )
    assert_redirected_to admin_posts_url(locale: 'da')
  end

  test 'should destroy post' do
    assert_difference('Post.count', -1) do
      delete admin_post_url(@post, locale: 'da')
    end

    assert_redirected_to admin_posts_url(locale: 'da')
  end
end
