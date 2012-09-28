Feature: Timestamps make sense with correct time difference
  As a user
  I want to see human readable time
  In order to judge correct time for each press

  Background:
    Given there is an existing RunStamp
    When I visit the "run_stamps" url

  Scenario: The list page shows correct time stamps, not epoch based
    Then the time for start and stop is human readable with a 2012 stamp

  Scenario: The list displays the time differance between start and stop
    Then the time differance is shown for each start and stop stamp
