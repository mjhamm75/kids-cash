Feature: Show a list of kids with available balance
  In order for to keep track of my kids money
  My wife
  Will credit and debit each child with the money that they earn or spend

  Background:
    Given I have kids named Bryson, Austin
    When I go to the list of kids

  Scenario: View all the children in a list
    Then I should see Bryson
    And I should see Austin

  Scenario: Add children to the list
    When I add a kid
    And I give the name Brooklyn
    And I give a balance of 0
    And I click the button Create Kid
    Then I should see Brooklyn
    And her balance should be 0