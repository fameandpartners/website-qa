Feature: Users
  As admin I can create a new user.
  As admin I can assign admin or user role.
  As admin I can delete a user.

  Background: As admin I am on Users page.
    Given open admin users page.

    Scenario: As admin I can create a new user.
      When I create a new user.
      Then it appears in user's list.
      And new user can be opened.