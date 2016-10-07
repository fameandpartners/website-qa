Feature: My Profile page.
  As user I can open own profile.
  As user I can modify my data.

  Background: Login as user.
    Given I am on Home page as logged in user.

  @smoke
  Scenario: Update 'Account Settings'.
    When I open 'My Details' page.
    Then I can modify First and Last names with:
      |First Name| Lorem   |
      |Last Name | Ipsum   |



  @wip
  Scenario: Email can be changed.

  @wip
  Scenario: Password can be changed.

  @wip
  Scenario: Profile fields can not be blank.