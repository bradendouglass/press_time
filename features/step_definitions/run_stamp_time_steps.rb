When /^I visit the "(.*?)" url$/ do |route_name|
  visit("/#{route_name}")
end

Then /^the time for start and stop is human readable with a ([0-9]{4}) stamp$/ do |year|
  page.should have_content(year)
end
