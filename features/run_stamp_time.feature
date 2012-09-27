Feature: Timestamps make sense with correct time difference
  As a user
  I want to see human readable time
  In order to judge correct time for each press

  Background:
    Given there is an existing RunStamp

  Scenario: The list page shows correct time stamps, not epoch based
    When I visit the "run_stamps" url
    Then the time for start and stop is human readable with a 2012 stamp
