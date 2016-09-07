Feature: Login page
  As registered user I can login.
  As unregistered user I can not login.
  As registered user I reset my password.

  Background: Open home page.
    Given I am on Home page.

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
    Then I want to login with Remember Me option.

  @wip #@smoke @regression
  Scenario: Login with Facebook account.
    When I open Login form.
    Then I want to login with Facebook account.
    And be sure I was logged in.

  @regression
  Scenario: User can NOT login with fake email.
    When I specify fake email.
    But password is correct.
    And I click 'Login' button.
    Then I will see "Invalid email or password." error message.

  @regression
  Scenario: User can NOT login with incorrect password.
    When I specify registered email.
    But password is incorrect.
    And I click 'Login' button.
    Then I will see "Invalid email or password." error message.

  @regression
  Scenario: User can NOT login with empty login but correct password.
    When I do not specify email.
    But password is correct.
    And I click 'Login' button.
    Then I will see "Invalid email or password." error message.

  @regression
  Scenario: User can NOT login without password.
    When I specify registered email.
    But password is empty.
    And I click 'Login' button.
    Then I will see "Invalid email or password." error message.

  @regression
  Scenario: User can NOT login with empty login and password fields.
    When I do not specify nor email nor password.
    Then I will see "Invalid email or password." error message.


  @wip #@regression
  Scenario: I should specify correct email format.
    When I specify incorrect email format.
    Then I will see "Please specify correct email" tooltip.


  @regression
  Scenario: Login from 'Forgot Password' form.
    When I open Login form.
    Then I go to Forgot Password form.
    And I can login from Forgot Password form.





