require 'rails_helper'

RSpec.describe "admin/calendars/edit", type: :view do
  before(:each) do
    @admin_calendar = assign(:admin_calendar, Admin::Calendar.create!(
      :admin_calendar_module => nil,
      :title => "MyString"
    ))
  end

  it "renders the edit admin_calendar form" do
    render

    assert_select "form[action=?][method=?]", admin_calendar_path(@admin_calendar), "post" do

      assert_select "input[name=?]", "admin_calendar[admin_calendar_module_id]"

      assert_select "input[name=?]", "admin_calendar[title]"
    end
  end
end
