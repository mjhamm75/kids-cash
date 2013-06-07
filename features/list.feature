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

  @javascript
  Scenario: Add children to the list
    When I add a kid
    And I give the name Jaxon
    And I give a balance of 0
    And I click the button Add Kid
    Then I should see Jaxon
    And her balance should be 0

  @javascript
  Scenario:  Go to kid detail
    When I click on the row for Bryson
    Then I am taken to the detail page for Bryson

  @javascript
  Scenario: Add credit to kid
    When I add a credit to Bryson for 10
    Then his balance is increased by 10

  @javascript
  Scenario: Add debit to kid
    When I add a debit to Bryson for 6
    Then his balance is decreased by 6