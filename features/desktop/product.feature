Feature: Product page.

  Background: Open product page.
    Given I am on product page.

    Scenario: Product page contains panel bars.
      Given left bar blocks:
        | Description         |
        | Fabric Information  |
        | About our model     |
        | Add to Moodboard    |
        | Share               |
      Given right bar elements:
        | Dress Size        |
        | Height & Hemline  |
        | Color             |
        | Customize         |
      When left side bar contains titles.
      Then they can be expanded and collapsed.
      And right side bar contains customization elements with "Add to bag" button.


    Scenario: As a user I can customize a dress and add it to bag.
