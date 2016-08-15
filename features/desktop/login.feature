Feature: Login page
  As registered user I can login.
  As unregistered user I can not login.
  As registered user I reset my password.

  Background: Open home page
    Given I am on home page.

  @regression
  Scenario: Check all Login form elements.
    When I open Login form.
    Then there are all required controls.

  @smoke @regression
  Scenario: Login with email.
    When I open Login form.
    Then I want to login with email as user.
    And be sure I was logged in.

  @regression
  Scenario: Login with Remember Me option.
    When I open Login form.
    Then I want to login with email and Remember Me option.

  @wip @smoke @regression
  Scenario: Login with Facebook account.
    When I open Login form.
    Then I want to login with Facebook account.
    And be sure I was logged in.

  @wip @smoke @regression
  Scenario: User can NOT login with incorrect email credentials.
    When I specify incorrect credentials.
    Then I will see "Invalid email or password." error message.
#    Implement table

  @wip @smoke @regression
  Scenario: Reset a password.
    When I open Login form.
    And I want to reset my password.
    Then message about receiving email with instructions appears.
    And I am able to reset my password.

  @regression
  Scenario: Login from Forgot Password form.
    When I open Login form.
    Then I go to Forgot Password form.
    And I can login from Forgot Password form.





