Feature: Header.

  Background: Open home page.
    Given I am on Home page.

  @smoke
  Scenario: User can change locale.
    When I change to "USA" locale.
    Then "USA" locale changed.
    And header message changed to "FREE SHIPPING TO THE USA, CANADA AND THE U.K.".
    When I change to "Australia" locale.
    Then "Australia" locale changed.
    And header message changed to "FREE SHIPPING WITHIN AUSTRALIA.".

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
  Scenario Outline: My Account menu.
    When I login as user.
    Then I hover mouse to 'My Account' link.
    And I can open <menu_item>.
    And url includes "<url>".
    Examples:
        |menu_item      |url          |
        |My Orders      |/user_orders |
        |My Moodboards  |/moodboards |
        |My Details     |/profile     |

  @smoke
  Scenario: User can logout.
    When I login as user.
    Then I hover mouse to 'My Account' link.
    And I logout.



