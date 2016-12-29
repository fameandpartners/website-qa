Feature: Sign up.
  As unregistered user I can sign up.

  Background: Open home page
    Given I am on Home page.

  Scenario: Check all Sign Up form elements.
    When I open "Sign Up" form.
    And there are all required Sign Up controls.

  @smoke
  Scenario: Create a new account.
    When I open "Sign Up" form.
    Then I want to create a new account.
    And be sure a new account was created.

  Scenario: Create a new account from 'Forgot Password' form.
    When I go to "Forgot Password" form.
    Then I want to go to "Sign Up" form from it.
    Then I want to create a new account.
    And be sure a new account was created.