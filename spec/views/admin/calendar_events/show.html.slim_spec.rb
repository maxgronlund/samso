require 'rails_helper'

RSpec.describe "admin/calendar_events/show", type: :view do
  before(:each) do
    @admin_calendar_event = assign(:admin_calendar_event, Admin::CalendarEvent.create!(
      :admin_calendar => nil,
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
  end
end
