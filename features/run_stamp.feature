Feature: Saving a runstamp through the web interface
  As a user
  I want to successfully track jobs
  In order to track overall job time

  Background:
    Given there is an existing RunStamp
    And I am at root
    And there is a Job Number

  @javascript
  Scenario: Successfully starting the counter
    When I click the "button" named "Start Press"
    Then a unix-time stamp is inserted into the "run_stamp_timeStart" field

  Scenario: Successfully ending the counter
    When there exists a unix-time stamp in the "run_stamp_timeStart" field
    And I click the "button" named "Stop Press"
    Then the run_stamp saves successfully

  Scenario: Saving a timestamp without a startTime or endTime
    When there exists no "job number" in the "run_stamp_jobNumber" field
    And there exists a unix-time stamp in the "run_stamp_timeStart" field
    And I click the "button" named "Stop Press"
    Then the program warns me profusely

  @javascript
  Scenario: Saving a timeStamp without a jobNumber
    When the "Job Number" is set to nil
    And I click the "button" named "Start Press"
    Then the Run Stamp isn't saved
