require 'rails_helper'

RSpec.describe "admin/calendars/new", type: :view do
  before(:each) do
    assign(:admin_calendar, Admin::Calendar.new(
      :admin_calendar_module => nil,
      :title => "MyString"
    ))
  end

  it "renders new admin_calendar form" do
    render

    assert_select "form[action=?][method=?]", admin_calendars_path, "post" do

      assert_select "input[name=?]", "admin_calendar[admin_calendar_module_id]"

      assert_select "input[name=?]", "admin_calendar[title]"
    end
  end
end
