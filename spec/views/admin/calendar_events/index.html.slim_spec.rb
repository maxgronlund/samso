require 'rails_helper'

RSpec.describe "admin/calendar_events/index", type: :view do
  before(:each) do
    assign(:admin_calendar_events, [
      Admin::CalendarEvent.create!(
        :admin_calendar => nil,
        :title => "Title"
      ),
      Admin::CalendarEvent.create!(
        :admin_calendar => nil,
        :title => "Title"
      )
    ])
  end

  it "renders a list of admin/calendar_events" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
