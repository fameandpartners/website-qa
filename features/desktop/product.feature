Feature: Product page.

  Background: Open product page.
    Given I am on product page.

    Scenario: Product page contains left info bar.
      When left side bar contains info blocks:
        | Description         |
        | Fabric Information  |
        | About our model     |
        | Add to Moodboard    |
        | Share               |
      Then they can be expanded or collapsed.

  Scenario: Product page contains right customization bar.
    When right bar contains customization elements:
      | Dress Size        |
      | Height & Hemline  |
      | Color             |
      | Customize         |
    Then they can be opened and closed.
    But "Add to bag" button becomes enabled when "Dress Size" and "Height & Hemline" are selected.

    @smoke
    Scenario: As a user I can customize a dress and add it to bag.
      When I select "Dress Size" and "Height & Hemline":
        | Dress Size        | US 10    |
        | Height & Hemline  | STANDARD |
      Then I can add a dress to bag.
      And I go to checkout process.


