Feature: Header.

  Background: Open home page.
    Given I am on Home page.

  @smoke
  Scenario: User can change locale.
    When I change to "USA" locale.
    Then "USA" locale changed.
    When I change to "Australia" locale.
    Then "Australia" locale changed.

  @smoke
  Scenario: Navigation Home menu.
    When I can see navigation home menu with all elements.
    Then I can open and close navigation home submenus:
      | New this week | New this week |
      | SHOP          | Shop          |
      | WEDDING SHOP  | WEDDING SHOP  |
      | EVENING SHOP  | EVENING SHOP  |
      | LOOKBOOKS     | LOOKBOOKS     |
      | BLOG          | BLOG          |
    And can open "Blog" page.

  @smoke
  Scenario: Open My profile via 'My Account' link.
    When I login as user.
    Then I open My profile via My Account link.
    And "Account settings" page opened.

  @smoke
  Scenario: As a registered user I can use My Account menu.
    When I login as user.
    Then I can open:
        |My Orders      |
        |My Moodboards  |
        |My Details     |

  @smoke
  Scenario: As a registered user can logout.
    When I login as user.
    Then I hover mouse to 'My Account' link.
    And I logout.

  Scenario: As a user I can use search for find a dress.
    When I open "Search".
    Then I can specify desired dress for search.
    And the founded dress can be opened.

  Scenario: As a user I can slide out/in shopping bag.
    When I slide out shopping bag.
    Then it contains bag's elements.
    And I can slide in shopping bag.