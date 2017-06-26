require 'test_helper'




class Admin::UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
     @user = users(:one)
  end

  test 'should get index' do
    puts @user.admin?
    #sign_in @user
    #get users_url
    #assert_response :success
  end

  #test 'should get new' do
  #  get admin_users_new_url
  #  assert_response :success
  #end
  #
  #test 'should get create' do
  #  get admin_users_create_url
  #  assert_response :success
  #end
  #
  #test 'should get edit' do
  #  get admin_users_edit_url
  #  assert_response :success
  #end
  #
  #test 'should get update' do
  #  get admin_users_update_url
  #  assert_response :success
  #end
  #
  #test 'should get destroy' do
  #  get admin_users_destroy_url
  #  assert_response :success
  #end
end
