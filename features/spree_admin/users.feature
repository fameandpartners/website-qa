Feature: Users (admin area).
  As admin I can create a new user.
  As admin I can assign admin or user role.
  As admin I can delete a user.

  Background: As admin I am on Users page.
    Given open admin users page.

    Scenario: As admin I can create a new user.
      When I create a new "user".
      Then it appears in user's list.
      And new user can be opened.

    Scenario: As admin I can create a new admin.
      When I create a new "admin".
      Then it appears in user's list.
      And new user can be opened.

    Scenario: As admin I can delete a user.
      When I create a new "user".
      Then it can be deleted.

    Scenario: As admin I can update user's details.
      When I create a new "user".
      Then it can be updated with new email and password.
      And I can login with new email and password.

    Scenario: As admin I can block a user.
      When I create a new "user".
      Then it can be blocked.
      And "Invalid email or password." message appears with login attempt.