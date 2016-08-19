Feature: My Profile page.
  As user I can open own profile.
  As user I can modify my data.

  Background: Login as user.
    Given I am on Home page as logged in user.




  Scenario: Can change My account settings.
    When I open My Details page.
    Then I can modify
    # implement table


  Scenario: