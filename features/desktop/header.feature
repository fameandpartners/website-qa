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
    Then I can open navigation home submenus:
      | New this week | New this week |
      | SHOP          | Shop          |
      | FAME WEDDINGS | FAME WEDDINGS |
      | LOOKBOOKS     | LOOKBOOKS     |
      | BLOG          | BLOG          |

  @smoke
  Scenario: Open My profile via 'My Account' link.
    When I login as user.
    Then I open My profile via My Account link.
    And Account settings page opened.

  @smoke
  Scenario: My Account menu.
    When I login as user.
    Then I can open:
        |My Orders      |
        |My Moodboards  |
        |My Details     |

  @smoke
  Scenario: User can logout.
    When I login as user.
    Then I hover mouse to 'My Account' link.
    And I logout.



