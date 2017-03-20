Feature: My Profile.
  As user I can open own profile.
  As user I can modify my data.

  @smoke
  Scenario: As a user I can change my profile data.
    Given I register a new user.
    When I open "My Details" page.
    Then I can modify profile data with random data.
    And can login with new updated email and password.
    Then I open "My Details" page.
    And check updated profile data.

  Scenario: Profile fields can not be blank.
    When I am on "My Details" page.
    Then I clear my profile fields.
    And try to save profile changes.
    But "can't be blank" appears for:
      | First name |
      | Last name  |
      | Email      |