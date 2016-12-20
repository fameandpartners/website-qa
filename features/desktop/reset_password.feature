Feature: Reset Password
  As registered user I can reset own password.
  As unregistered user I can not reset own password.

  Background: Open home page
    Given I am on Home page.

  Scenario: Check all reset password elements.
    When I go to "Forgot Password" form.
    And there are all "Forgot Password" form controls.
    Then I specify email for password reset.
    And confirm password reset.
    And there are all "Reset Password" page controls.

  @smoke
  Scenario: Reset a password.
    When I open Login form.
    And I want to reset my password.
    Then message about receiving email with instructions appears.
    And I am able to reset my password.
