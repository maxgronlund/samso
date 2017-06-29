require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get new_user_url(locale: 'en')
    assert_response :success
  end

  # test "should create user" do
  #   assert_difference('User.count') do
  #     post users_url(
  #       locale: 'en',
  #       params: {
  #         user: {
  #           email: @user.email,
  #           name: @user.name,
  #           password: 'ej5yafohL',
  #           password_confirmation: 'ej5yafohL'
  #         }
  #       }
  #     )
  #   end
  #   assert_redirected_to root_path
  # end

  test "should show user" do
    get user_url(@user, locale: 'en')
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user, locale: 'en')
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user, locale: 'en'), params: { user: { id: @user.id, email: @user.email, name: @user.name } }
    assert_redirected_to user_url(@user, locale: 'en')
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user, locale: 'en')
    end

    assert_redirected_to users_url
  end
end
