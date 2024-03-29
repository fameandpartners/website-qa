Feature: Login.
  As registered user I can login.
  As unregistered user I can not login.
  As registered user I reset my password.

  Background: Open home page.
    Given I am on Home page.

  Scenario: Check all Login form elements.
    When I open Login form.
    Then there are all required controls.

  @smoke
  Scenario: Login with email.
    When I open Login form.
    Then I want to login with email as user.
    And be sure I was logged in.

  Scenario: Login with Remember Me option.
    When I open Login form.
    Then I want to login with Remember Me option.

  @smoke
  Scenario: Login with Facebook account.
    When I open Login form.
    Then I want to login with Facebook account.
    And be sure I was logged in.

  Scenario: User can NOT login with fake email.
    When I open Login form.
    Then I specify fake email.
    But password is correct.
    And I click 'Login' button.
    Then I will see "Invalid email or password." error message.

  Scenario: User can NOT login with incorrect password.
    When I open Login form.
    Then I specify registered email.
    But password is incorrect.
    And I click 'Login' button.
    Then I will see "Invalid email or password." error message.

  Scenario: User can NOT login with empty login but correct password.
    When I open Login form.
    Then I do not specify email.
    But password is correct.
    And I click 'Login' button.
    Then I will see "Invalid email or password." error message.

  Scenario: User can NOT login without password.
    When I open Login form.
    Then I specify registered email.
    But password is empty.
    And I click 'Login' button.
    Then I will see "Invalid email or password." error message.

  Scenario: User can NOT login with empty login and password fields.
    When I open Login form.
    Then I do not specify nor email nor password.
    And I will see "Invalid email or password." error message.

#  @wip
#  Scenario: I should specify correct email format.
#    When I specify incorrect email format.
#    Then I will see "Please specify correct email" tooltip.

  Scenario: Login from 'Forgot Password' form.
    When I open Login form.
    Then I go to "Forgot Password" form.
    And I can login from "Forgot Password" form.





