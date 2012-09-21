Feature: Stop a Press run with a reason
  As a user
  I want to give a reason for stopping my press
  In order to track common problems


  Background:
    Given I am at root
    And there is an existing RunStamp
    And there is a Job Number

  Scenario: stopping the press using the reason pulldown
    When I click the "button" named "Start Press"
    And there exists a unix-time stamp in the "run_stamp_timeStart" field
    And I select "Registration" from the drop down list: "run_stamp_reason"
    Then I click the "button" named "Stop Press"
    And the run_stamp saves successfully
