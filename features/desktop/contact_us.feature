Feature: Contact Us.

  Background: Open 'Contact Us' page.
    Given I am on Home page.

    Scenario: User can open 'Contact Us' page.
      When I open 'Contact Us' page.
      Then there are all requires controls.

    Scenario Outline: User can send an enquiry.
      When I fill in contact info:

      Then I select <Help> type.
      And select <Category>.

      Examples:
      | Help  | Category  |
