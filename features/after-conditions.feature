@preconditions
Feature: Set after conditions.

  Background: Login as admin.
    Given I login as "admin".

  Scenario: disable feature flags.
    When I am on Fame admin feature flags.
    Then disable next flags:
      | i=Change       | i_equal_change      |
      | China New Year | cny_delivery_delays |
      | Fast Making    | express_making      |
    Then expire cache.

  Scenario: Delete all active Sale(s).
    When I go to Sales tab.
    Then deactivate active Sale(s).