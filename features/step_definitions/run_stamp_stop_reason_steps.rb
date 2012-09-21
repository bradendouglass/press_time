When /^I select "(.*?)" from the drop down list: "(.*?)"$/ do |choice, list_id|
  page.should have_css('select')
  select(choice, :from => list_id)
end
