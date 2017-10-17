When('I visit the {string} page') do |page|
  case page
  when 'landing_page'
    visit root_path
  when 'login_page'
    visit new_session_path
  when 'signup_page'
    visit new_user_path
  end
end
