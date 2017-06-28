require 'test_helper'

class ContentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @content = contents(:one)
    @system_setup = admin_system_setups(:one)
    sign_in users(:one)
  end

  test 'should get index' do
    get admin_contents_url(locale: 'da')
    assert_response :success
  end

  test 'should get new' do
    get new_admin_content_url(locale: 'da')
    assert_response :success
  end

  test 'should create content' do
    assert_difference('Content.count') do
      post admin_contents_url, params:
      {
        content: {
          body: @content.body,
          contentable_id: @system_setup.id,
          contentable_type: @system_setup.class.name,
          identifier: @content.identifier,
          position: @content.position,
          title: @content.title
        }
      }
    end
    assert_redirected_to admin_contents_url(locale: 'da')
  end

  test 'should show content' do
    get admin_contents_url(locale: 'da')
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_content_url(@content, locale: 'da')
    assert_response :success
  end

  test 'should update content' do
    patch admin_content_url(
      id: @content.id,
      locale: 'da',
      params: {
        content: {
          body: @content.body,
          contentable: @system_setup,
          identifier: @content.identifier,
          position: @content.position,
          title: @content.title
        }
      }
    )
    assert_redirected_to admin_contents_url(locale: 'da')
  end

  test 'should destroy content' do
    assert_difference('Content.count', -1) do
      delete admin_content_url(@content, locale: 'da')
    end

    assert_redirected_to admin_contents_url(locale: 'da')
  end
end
