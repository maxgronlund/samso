require 'rails_helper'

RSpec.describe "admin/calendars/index", type: :view do
  before(:each) do
    assign(:admin_calendars, [
      Admin::Calendar.create!(
        :admin_calendar_module => nil,
        :title => "Title"
      ),
      Admin::Calendar.create!(
        :admin_calendar_module => nil,
        :title => "Title"
      )
    ])
  end

  it "renders a list of admin/calendars" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
