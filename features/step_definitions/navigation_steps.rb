When('I visit the {string} page') do |page|
  case page
  when 'landing_page'
    visit root_path
  when 'login_page'
    visit new_session_path
  when 'signup_page'
    visit new_user_path
  when 'blog_post'
    visit blog_post_page('Blog post')
  end
end

When('I visit the blog_page page with access to {string}') do |title|
  page = Page.find_by(title: title)
  visit page_path(I18n.locale, page)
end

When('I visit the page named {string}') do |page_title|
  page = Page.find_by(title: page_title, locale: I18n.locale)
  visit page_path(I18n.locale, page)
end
