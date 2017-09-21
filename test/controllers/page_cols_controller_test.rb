require 'test_helper'

class PageColsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page_col = page_cols(:one)
  end

  test 'should get index' do
    get page_cols_url
    assert_response :success
  end

  test 'should get new' do
    get new_page_col_url
    assert_response :success
  end

  test 'should create page_col' do
    assert_difference('PageCol.count') do
      post page_cols_url, params: { page_col: { layout: @page_col.layout, page_row_id: @page_col.page_row_id } }
    end

    assert_redirected_to page_col_url(PageCol.last)
  end

  test 'should show page_col' do
    get page_col_url(@page_col)
    assert_response :success
  end

  test 'should get edit' do
    get edit_page_col_url(@page_col)
    assert_response :success
  end

  test 'should update page_col' do
    patch page_col_url(@page_col), params: { page_col: { layout: @page_col.layout, page_row_id: @page_col.page_row_id } }
    assert_redirected_to page_col_url(@page_col)
  end

  test 'should destroy page_col' do
    assert_difference('PageCol.count', -1) do
      delete page_col_url(@page_col)
    end

    assert_redirected_to page_cols_url
  end
end
