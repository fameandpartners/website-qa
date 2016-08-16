Feature: Sign Up.
  As unregistered user I can can Sign Up.

  @wip @smoke @regression
  Scenario: Create a new account.
    When I open Login form.
    Then I want to create a new account.
    And be sure a new account was createdf .

  @wip @regression
  Scenario: Create a new account from Forgot Password form.
    When I open Login form.
    Then I go to Forgot Password form.
    And create a new account from Forgot Password form.

