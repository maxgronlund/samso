require 'test_helper'

class PageRowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page_row = page_rows(:one)
  end

  test 'should get index' do
    get page_rows_url
    assert_response :success
  end

  test 'should get new' do
    get new_page_row_url
    assert_response :success
  end

  test 'should create page_row' do
    assert_difference('PageRow.count') do
      post page_rows_url, params: { page_row: { name: @page_row.name, page_id: @page_row.page_id, type: @page_row.type } }
    end

    assert_redirected_to page_row_url(PageRow.last)
  end

  test 'should show page_row' do
    get page_row_url(@page_row)
    assert_response :success
  end

  test 'should get edit' do
    get edit_page_row_url(@page_row)
    assert_response :success
  end

  test 'should update page_row' do
    patch page_row_url(@page_row), params: { page_row: { name: @page_row.name, page_id: @page_row.page_id, type: @page_row.type } }
    assert_redirected_to page_row_url(@page_row)
  end

  test 'should destroy page_row' do
    assert_difference('PageRow.count', -1) do
      delete page_row_url(@page_row)
    end

    assert_redirected_to page_rows_url
  end
end
