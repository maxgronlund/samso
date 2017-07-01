require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page = pages(:one)
  end

  test 'should show page' do
    get page_url(@page, locale: 'en')
    assert_response :success
  end
end
