Feature: Login page
  As registered user I can login
  As unregistered user I can not login and can register


  Background: Open home page
    Given I am on home page

  @done
  Scenario: Login with email
    When I open Login form.
    Then I want to login with email as user.
    And be sure I was logged in.

  @pending
  Scenario: Sign Up with email.
    When I open Login form.
    Then I want to sign up with email.
    And be sure I was signed up.

  @pending
  Scenario: Sign Up with Facebook account.
    When I open Login form.
    Then I want to sign up with Facebook account.
    And be sure I was signed up.



