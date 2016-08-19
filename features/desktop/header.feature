Feature: Top navigation menu.

  Background: Open home page.
    Given I am on Home page.

  @wip
  Scenario: Header contains required elements.


#  Scenario: Login form opens via 'My Account' link if user is not logged in.
#    When I click My account link.
#    Then

  @smoke
  Scenario: Open My profile via 'My Account' link.
    When I login as user.
    Then I open My profile via My Account link.
    And Account settings page opened.

  @wip @smoke
  Scenario Outline: My Account menu.
    When I login as user.
    Then I hover mouse to 'My Account' link.
    And I can open <menu_item>.

    Examples:
    |menu_item      |
    |My Orders      |
    |My Moodboards  |
    |My Details     |

  Scenario: User can logout.
    When I login as user.
    Then I hover mouse to 'My Account' link.
    And I logout.