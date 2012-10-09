Given /^there is an existing RunStamp$/ do
  Fabricate(:run_stamp)
  RunStamp.count.should == 1
end

Given /^there is a Job Number$/ do
  fill_in("Job Number", :with => '100-1')
end

Then /^a unix\-time stamp is inserted into the "(.*?)" field$/ do |field|
  @utime = find_field(field).value
  @utime =~ [0-9]
  @utime != nil
end

When /^there exists a unix\-time stamp in the "(.*?)" field$/ do |field|
  fill_in(field, :with => Time.now.to_i)
end

Then /^the run_stamp saves successfully$/ do
  current_path.should == root_path
  RunStamp.count.should == 2
  last_stamp = RunStamp.last
  last_stamp.timeStart < last_stamp.timeStop
end

When /^there exists no "(.*?)" in the "(.*?)" field$/ do |name, field|
  fill_in(field, :with => '')
end

Then /^the program warns me profusely$/ do
  RunStamp.count.should == 1
  page.should have_css('header div#flash_error')
end

When /^the "(.*?)" is set to nil$/ do |field|
  fill_in(field, :with => '')
end

Then /^the Run Stamp isn't saved$/ do
  RunStamp.count.should == 1
end
