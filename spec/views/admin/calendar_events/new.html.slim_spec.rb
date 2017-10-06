require 'rails_helper'

RSpec.describe "admin/calendar_events/new", type: :view do
  before(:each) do
    assign(:admin_calendar_event, Admin::CalendarEvent.new(
      :admin_calendar => nil,
      :title => "MyString"
    ))
  end

  it "renders new admin_calendar_event form" do
    render

    assert_select "form[action=?][method=?]", admin_calendar_events_path, "post" do

      assert_select "input[name=?]", "admin_calendar_event[admin_calendar_id]"

      assert_select "input[name=?]", "admin_calendar_event[title]"
    end
  end
end
