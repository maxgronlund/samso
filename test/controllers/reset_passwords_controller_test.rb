require 'test_helper'

class ResetPasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reset_passwords_index_url
    assert_response :success
  end

end
