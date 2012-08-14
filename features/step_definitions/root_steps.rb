Given /^I am at root$/ do
  visit('/')
  page.should have_content("New Run Stamp")
end

Then /^I should see a button named "(.*?)"$/ do |button|
  page.should have_content(button)
end

Then /^I should see a field named "(.*?)"$/ do |field|
  page.should have_content(field)
end
