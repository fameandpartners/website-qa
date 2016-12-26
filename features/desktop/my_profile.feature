Feature: My Profile page.
  As user I can open own profile.
  As user I can modify my data.

  @WIP
  Scenario: As a user I can change my First and Last names.
    When I am on "My Details" page.
    Then I can modify First and Last names with:
      |First Name| Lorem   |
      |Last Name | Ipsum   |
    And names were updated.

  @smoke
  Scenario: As a user I can change my email.
     #add parallel temp emails
    When I registered as a new user.
    Then I can change my email.
    And login with new email.

  @WIP
  Scenario: As a user I can change my password.
    When I registered as a new user.
    Then I can change my password.
    And can login with new password.

  Scenario: Profile fields can not be blank.
    When I am on "My Details" page.
    Then I clear my profile fields.
    And try to save profile changes.
    But "can't be blank" appears for:
      | First name |
      | Last name  |
      | Email      |