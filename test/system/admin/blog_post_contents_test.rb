require "application_system_test_case"

class Admin::BlogPostContentsTest < ApplicationSystemTestCase
  setup do
    @admin_blog_post_content = admin_blog_post_contents(:one)
  end

  test "visiting the index" do
    visit admin_blog_post_contents_url
    assert_selector "h1", text: "Admin/Blog Post Contents"
  end

  test "creating a Blog post content" do
    visit admin_blog_post_contents_url
    click_on "New Admin/Blog Post Content"

    fill_in "Admin blog post", with: @admin_blog_post_content.admin_blog_post_id
    fill_in "Body", with: @admin_blog_post_content.body
    fill_in "Image", with: @admin_blog_post_content.image
    fill_in "Image caption", with: @admin_blog_post_content.image_caption
    fill_in "Position", with: @admin_blog_post_content.position
    fill_in "Title", with: @admin_blog_post_content.title
    click_on "Create Blog post content"

    assert_text "Blog post content was successfully created"
    click_on "Back"
  end

  test "updating a Blog post content" do
    visit admin_blog_post_contents_url
    click_on "Edit", match: :first

    fill_in "Admin blog post", with: @admin_blog_post_content.admin_blog_post_id
    fill_in "Body", with: @admin_blog_post_content.body
    fill_in "Image", with: @admin_blog_post_content.image
    fill_in "Image caption", with: @admin_blog_post_content.image_caption
    fill_in "Position", with: @admin_blog_post_content.position
    fill_in "Title", with: @admin_blog_post_content.title
    click_on "Update Blog post content"

    assert_text "Blog post content was successfully updated"
    click_on "Back"
  end

  test "destroying a Blog post content" do
    visit admin_blog_post_contents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Blog post content was successfully destroyed"
  end
end
