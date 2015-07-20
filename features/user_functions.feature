Feature: user credentials

  Scenario: as not authenticated user visit root path
    Given I am not authenticated
    And I go to root path
    Then I should see log in option
    
  Scenario: as not authenticated user visit top 10 path
    Given I am not authenticated
    And I go to top ten this week path
    Then I should see log in option
    
  Scenario: as authenticated user visit top 10 path
    Given I am a logged in user
    And I go to top ten this week path
    Then I should see some pictures
    
  