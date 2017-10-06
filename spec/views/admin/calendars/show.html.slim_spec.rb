require 'rails_helper'

RSpec.describe "admin/calendars/show", type: :view do
  before(:each) do
    @admin_calendar = assign(:admin_calendar, Admin::Calendar.create!(
      :admin_calendar_module => nil,
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
  end
end
