require 'test_helper'

class ContentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @content = contents(:one)
    @system_setup = admin_system_setups(:one)
  end

  test 'should get index' do
    get contents_url(locale: 'da')
    assert_response :success
  end

  test 'should get new' do
    get new_content_url(locale: 'da')
    assert_response :success
  end

  test 'should create content' do
    assert_difference('Content.count') do
      post contents_url, params:
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
    assert_redirected_to content_url(Content.last, locale: 'da')
  end

  test 'should show content' do
    get content_url(@content)
    assert_response :success
  end

  test 'should get edit' do
    get edit_content_url(@content, locale: 'da')
    assert_response :success
  end

  test 'should update content' do
    patch content_url(
      @content,
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
    assert_redirected_to content_url(@content, locale: 'da')
  end

  test 'should destroy content' do
    assert_difference('Content.count', -1) do
      delete content_url(@content, locale: 'da')
    end

    assert_redirected_to contents_url(locale: 'da')
  end
end