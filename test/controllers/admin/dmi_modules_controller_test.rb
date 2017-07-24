require 'test_helper'

class Admin::DmiModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dmi_module  = admin_dmi_modules(:dmi_module_one)
    @page_module = page_modules(:dmi_module)
    @page        = @page_module.page
    @user = users(:one)
    Warden.test_mode!
    sign_in(@user)
  end

  teardown do
    Warden.test_reset!
  end

  test 'should get edit' do
    get edit_admin_page_dmi_module_url(@page, @dmi_module, locale: 'da')
    assert_response :success
  end

  test 'should update admin_dmi_module' do
    patch admin_page_dmi_module_url(@page, @dmi_module, locale: 'da'), params: {
      admin_dmi_module: {
        forecast_duration: @dmi_module.forecast_duration
      }
    }
    assert_redirected_to admin_page_url(@dmi_module.page, locale: 'da')
  end

  test 'should destroy admin_dmi_module' do
    assert_difference('Admin::DmiModule.count', -1) do
      delete admin_page_page_module_url(@page, @page_module, locale: 'da')
    end
    assert_redirected_to admin_page_url(@page, locale: 'da')
  end
end
