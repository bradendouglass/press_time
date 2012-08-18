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

When /^I click the "(.*?)" named "(.*?)"$/ do |object, name|
  click_on(name)
end

Then /^the "(.*?)" named "(.*?)" dissapears$/ do |object, name|
  page.should_not == name
end

Then /^the "(.*?)" with a css value of "(.*?)" appears$/ do |object, css|
  page.should have_css(css)
end
