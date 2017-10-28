Then('I can click on a {string} link') do |link_name|
  click_on I18n.t(link_name)
end

Then(/^Does it look right$/) do
  ask('does that look right?')
end

Then('I can click {string}') do |translation|
  click_on I18n.t(translation)
end
