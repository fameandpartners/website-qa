@regression
Feature: 404 page.

  Background: Open Home page.
    Given I am on Home page.

    @debug
  Scenario Outline: Verify 404 page displays for user with invalid url parameters.
    When I specify non existing <country> URL.
    Then 404 page displays to user.
    And it has:
      | Caption question | Looking for something?                                                           |
      | Message          | Sorry, this page doesn't exist.                                                  |
      | Text             | Try our homepage to see what's new and start customizing.                        |
      | Contact message  | Still can't find what you're looking for? E-mail us at team@fameandpartners.com. |

    Examples:
      | country   |
      | USA       |
      | Australia |