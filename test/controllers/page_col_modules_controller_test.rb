require 'test_helper'

class PageColModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page_col_module = page_col_modules(:one)
  end

  test 'should get new' do
    get new_page_col_module_url
    assert_response :success
  end

  test 'should create page_col_module' do
    assert_difference('PageColModule.count') do
      post(
        page_col_modules_url(locale: I18n.locale),
        params: {
          page_col_module: {
            moduleable_id: @page_col_module.moduleable_id,
            moduleable_type: @page_col_module.moduleable_type,
            page_col_id: @page_col_module.page_col_id,
            position: @page_col_module.position
          }
        }
      )
    end

    assert_redirected_to page_col_module_url(PageColModule.last)
  end

  test 'should show page_col_module' do
    get page_col_module_url(@page_col_module)
    assert_response :success
  end

  test 'should get edit' do
    get edit_page_col_module_url(@page_col_module)
    assert_response :success
  end

  test 'should update page_col_module' do
    patch(
      page_col_module_url(
        @page_col_module,
        locale: I18n.locale,
        params: {
          page_col_module: {
            moduleable_id: @page_col_module.moduleable_id,
            moduleable_type: @page_col_module.moduleable_type,
            page_col_id: @page_col_module.page_col_id,
            position: @page_col_module.position
          }
        }
      )
    )
    assert_redirected_to page_col_module_url(@page_col_module)
  end

  test 'should destroy page_col_module' do
    assert_difference('PageColModule.count', -1) do
      delete page_col_module_url(@page_col_module)
    end

    assert_redirected_to page_col_modules_url
  end
end
