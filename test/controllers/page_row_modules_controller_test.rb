require 'test_helper'

class PageRowModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page_row_module = page_row_modules(:one)
  end

  test "should get index" do
    get page_row_modules_url
    assert_response :success
  end

  test "should get new" do
    get new_page_row_module_url
    assert_response :success
  end

  test "should create page_row_module" do
    assert_difference('PageRowModule.count') do
      post page_row_modules_url, params: { page_row_module: { moduleable_id: @page_row_module.moduleable_id, moduleable_type: @page_row_module.moduleable_type, page_row_id: @page_row_module.page_row_id, position: @page_row_module.position, slot_id: @page_row_module.slot_id } }
    end

    assert_redirected_to page_row_module_url(PageRowModule.last)
  end

  test "should show page_row_module" do
    get page_row_module_url(@page_row_module)
    assert_response :success
  end

  test "should get edit" do
    get edit_page_row_module_url(@page_row_module)
    assert_response :success
  end

  test "should update page_row_module" do
    patch page_row_module_url(@page_row_module), params: { page_row_module: { moduleable_id: @page_row_module.moduleable_id, moduleable_type: @page_row_module.moduleable_type, page_row_id: @page_row_module.page_row_id, position: @page_row_module.position, slot_id: @page_row_module.slot_id } }
    assert_redirected_to page_row_module_url(@page_row_module)
  end

  test "should destroy page_row_module" do
    assert_difference('PageRowModule.count', -1) do
      delete page_row_module_url(@page_row_module)
    end

    assert_redirected_to page_row_modules_url
  end
end
