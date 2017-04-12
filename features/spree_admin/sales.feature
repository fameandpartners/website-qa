Feature: Sales.
  As admin I can create sales.

  Background: Login to Spree admin area.
    Given I login to admin area.

  Scenario Outline: Applying a discount coupon with active percent sale.
    When I create a new Sale.
    Then make it Percentage discount type, active and sitewide.
    And verify that sale price is applied to products on <country> website.
    Then add products into your cart and go to Checkout.
    But apply an additional discount using a code.
    Then get out of Checkout and continue shopping
    And go to any of the category pages.
    And user won't get 500th error.
    But delete created sale.

    Examples:
      | country   |
      | USA       |
      | Australia |