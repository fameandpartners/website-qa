Feature: Reset Password
  As registered user I can reset own password.
  As unregistered user I can not reset own password.

  Background: Open home page
    Given I am on Home page.

  @wip @regression
  Scenario: Check all Reset Password form elements.
    When I open Forgot Password page.
    And there are all Reset Password page controls.

  @wip @smoke @regression
  Scenario: Reset a password.
    When I open Login form.
    And I want to reset my password.
    Then message about receiving email with instructions appears.
    And I am able to reset my password.

  Scenario: Required filed
    When bla