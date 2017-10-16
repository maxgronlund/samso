Then("a guest can se a link {string}") do |string|
  page.should have_content(string)
end