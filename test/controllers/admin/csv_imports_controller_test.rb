require 'test_helper'

class Admin::CsvImportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_csv_import = admin_csv_imports(:one)
    @user = users(:one)
  end

  test 'should get index' do
    get admin_csv_imports_url
    assert_response :success
  end

  test 'should get new' do
    get new_admin_csv_import_url
    assert_response :success
  end

  # test 'should create admin_csv_import' do
  #   assert_difference('Admin::CsvImport.count') do
  #     post admin_csv_imports_url, params: {
  #       admin_csv_import: {
  #         comments: @admin_csv_import.comments,
  #         import_type: @admin_csv_import.import_type,
  #         name: @admin_csv_import.name,
  #         summary: @admin_csv_import.summary
  #       }
  #     }
  #   end
  #   assert_redirected_to admin_csv_import_url(Admin::CsvImport.last)
  # end

  test 'should show admin_csv_import' do
    get admin_csv_import_url(@admin_csv_import, locale: 'da')
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_csv_import_url(@admin_csv_import, locale: 'da')
    assert_response :success
  end

  test 'should update admin_csv_import' do
    patch admin_csv_import_url(@admin_csv_import, locale: 'da'), params: {
      admin_csv_import: {
        comments: @admin_csv_import.comments,
        import_type: @admin_csv_import.import_type,
        name: @admin_csv_import.name,
        summary: @admin_csv_import.summary
      }
    }
    assert_redirected_to admin_csv_import_url(@admin_csv_import)
  end

  test 'should destroy admin_csv_import' do
    assert_difference('Admin::CsvImport.count', -1) do
      delete admin_csv_import_url(@admin_csv_import, locale: 'da')
    end
    assert_redirected_to admin_csv_imports_url
  end
end
