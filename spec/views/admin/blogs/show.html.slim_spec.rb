require 'rails_helper'

RSpec.describe "admin/blogs/show", type: :view do
  before(:each) do
    @admin_blog = assign(:admin_blog, Admin::Blog.create!(
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
  end
end
