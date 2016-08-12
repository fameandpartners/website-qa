Feature: Login page
  As registered user I can login.
  As unregistered user I can not login and can register.
  As unregistered user I can Logout.


  Background: Open home page
    Given I am on home page.

  @smoke
  Scenario: Login with email
    When I open Login form.
    Then I want to login with email as user.
    And be sure I was logged in.

  @smoke
  Scenario: Sign Up with email.
    When I open Login form.
    Then I want to sign up with email.
    And be sure I was signed up.

  @smoke
  Scenario: Login with Facebook account.
    When I open Login form.
    Then I want to login with Facebook account.
    And be sure I was logged in.

  Scenario: User can NOT login with incorrect email credentials.
    When I specify incorrect credentials.
    Then I will see "Invalid email or password." error message.

#    Implement table


