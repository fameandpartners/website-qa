Feature: Fast making.

  Scenario: Express Making can be enabled or disabled.
    Given I login to admin area.
    Then go to Fame admin feature flags.
    And enable Express Making.
    But check it is available on storefront.
    Then go to Fame admin feature flags.
    And disable Express Making.
    But check it is unavailable on storefront.


