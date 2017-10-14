require 'rails_helper'

RSpec.describe "admin/blogs/new", type: :view do
  before(:each) do
    assign(:admin_blog, Admin::Blog.new(
      :title => "MyString"
    ))
  end

  it "renders new admin_blog form" do
    render

    assert_select "form[action=?][method=?]", admin_blogs_path, "post" do

      assert_select "input[name=?]", "admin_blog[title]"
    end
  end
end
