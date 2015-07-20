Feature: Mark a cat
  
  Scenario: Display a root page
    Given that there are some cats in database
    And I am a logged in "user"
    And I go to root path
    Then I should see some pictures
    
  Scenario: Display index page
    Given that there are some cats in database
    And I am a logged in "admin"
    And I go to cat index page
    Then I should see some pictures
    And I should see a page title