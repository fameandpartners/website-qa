Feature: Product page.

  Background: Open product page.
    Given I am on product page.

  Scenario: Product page contains left info bar.
    When left side bar contains info blocks:
      | Description        |
      | Fabric Information |
      | About our model    |
      | Add to Moodboard   |
      | Share              |
    Then they can be expanded or collapsed.

  Scenario: Product page contains right customization bar.
    When right bar contains customization elements:
      | Color        |
      | Customize    |
      | Size Profile |
    Then they can be opened and closed.
    But "Add to bag" button redirects to Checkout when "Size Profile" is selected.

  @smoke
  Scenario: As a user I can customize a dress and add it to bag.
    When I select random "Dress Size" and "Growth".
    Then select random customization.
    Then I can add a dress to bag.
    And I go to checkout process.

  Scenario: I can open free styling session from PDP.
    Then I can open Free Styling Session via "Book NOW" link.
    And Free Styling Session is available.
    Then I can open Free Styling Session via "Amber Bond" image link.
    And Free Styling Session is available.
