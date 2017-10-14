require 'rails_helper'

RSpec.describe "admin/calendar_events/edit", type: :view do
  before(:each) do
    @admin_calendar_event = assign(:admin_calendar_event, Admin::CalendarEvent.create!(
      :admin_calendar => nil,
      :title => "MyString"
    ))
  end

  it "renders the edit admin_calendar_event form" do
    render

    assert_select "form[action=?][method=?]", admin_calendar_event_path(@admin_calendar_event), "post" do

      assert_select "input[name=?]", "admin_calendar_event[admin_calendar_id]"

      assert_select "input[name=?]", "admin_calendar_event[title]"
    end
  end
end
