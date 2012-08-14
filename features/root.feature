Feature: Root of application is new timestamp
  As a user
  I want to begin time stamping jobs
  In order to track job time

  Scenario: When the user navigates to the root url they are directed to the time stamps section
    Given I am at root
    Then I should see a button named "Start Press"
    And I should see a field named "Job Number"
