require 'test_helper'

class Admin::FootersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_footer = admin_footers(:one)
    @user = users(:one)
    Warden.test_mode!
    sign_in(@user)
  end

  teardown do
    Warden.test_reset!
  end

  test 'should get index' do
    get admin_footers_url
    assert_response :success
  end

  test 'should get new' do
    get new_admin_footer_url
    assert_response :success
  end

  test 'should create admin_footer' do
    assert_difference('Admin::Footer.count') do
      post admin_footers_url, params: {
        admin_footer: {
          about_link: @admin_footer.about_link,
          about_link_name: @admin_footer.about_link_name,
          copyright: @admin_footer.copyright,
          email: @admin_footer.email,
          email_name: @admin_footer.email_name,
          info: @admin_footer.info,
          locale: @admin_footer.locale,
          terms_of_usage_link: @admin_footer.terms_of_usage_link,
          terms_of_usage_link_name: @admin_footer.terms_of_usage_link_name,
          title: @admin_footer.title
        }
      }
    end

    assert_redirected_to admin_footer_url(Admin::Footer.last)
  end

  test 'should show admin_footer' do
    get admin_footer_url(@admin_footer)
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_footer_url(@admin_footer)
    assert_response :success
  end

  test 'should update admin_footer' do
    patch admin_footer_url(@admin_footer), params: {
      admin_footer: {
        about_link: @admin_footer.about_link,
        about_link_name: @admin_footer.about_link_name,
        copyright: @admin_footer.copyright,
        email: @admin_footer.email,
        email_name: @admin_footer.email_name,
        info: @admin_footer.info,
        locale: @admin_footer.locale,
        terms_of_usage_link: @admin_footer.terms_of_usage_link,
        terms_of_usage_link_name: @admin_footer.terms_of_usage_link_name,
        title: @admin_footer.title
      }
    }
    assert_redirected_to admin_footer_url(@admin_footer)
  end

  test 'should destroy admin_footer' do
    assert_difference('Admin::Footer.count', -1) do
      delete admin_footer_url(@admin_footer)
    end
    assert_redirected_to admin_footers_url
  end
end
