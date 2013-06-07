Feature: View detail of a kid

  Scenario:  View credit and devit detail for past month
    Given there is a detail page for Bryson
    And he has a debit of -10
    And he has a credit of 9
    Then he should have a debit of -10
    And he should have a credit of 9