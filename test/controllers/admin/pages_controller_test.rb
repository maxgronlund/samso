require 'test_helper'

class Admin::PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page = pages(:front_page)
    @user = users(:one)
    @admin_system_setup = admin_system_setups(:one)
  end

  test 'should get index' do
    get admin_pages_url
    assert_response :success
  end

  test 'should get new' do
    get new_admin_page_url
    assert_response :success
  end

  test 'should create page' do
    assert_difference('Page.count') do
      post admin_pages_url params: {
        page: {
          active: @page.active,
          locale: @page.locale,
          menu_title: @page.menu_title,
          menu_id: @page.menu_id,
          title: @page.title,
          user_id: @page.user_id
        },
        locale: 'da'
      }
    end
    assert_redirected_to admin_page_url(Page.last, locale: 'da')
  end

  test 'should show page' do
    get admin_page_url(@page, locale: 'da')
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_page_url(@page, locale: 'en')
    assert_response :success
  end

  test 'should update page' do
    patch admin_page_url(@page, locale: 'en'), params: {
      page: {
        id: @page.id,
        active: @page.active,
        locale: @page.locale
      }
    }
    assert_redirected_to admin_page_url(@page, locale: 'en')
  end

  test 'should destroy page' do
    assert_difference('Page.count', -1) do
      delete admin_page_url(@page, locale: 'en')
    end
    assert_redirected_to admin_pages_url
  end
end
