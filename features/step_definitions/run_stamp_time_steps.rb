When /^I visit the "(.*?)" url$/ do |route_name|
  visit("/#{route_name}")
end

Then /^the time for start and stop is human readable with a ([0-9]{4}) stamp$/ do |year|
  page.should have_content(year)
end

Then /^the time differance is shown for each start and stop stamp$/ do
  stamp = Fabricate(:run_stamp)
  RunStamp.count.should == 2
  stampdiff = stamp.timeStop - stamp.timeStart
  stampdifftime = Time.at(stampdiff).utc.strftime("(%H) hours (%M) min (%S) seconds")
  page.should have_content(stampdifftime)
end
