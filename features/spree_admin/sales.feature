Feature: Sales.
  As admin I can create sales.

  Background: Login to Spree admin area.
    Given I login as "admin".

  Scenario Outline: Applying a discount coupon with active Percent sale.
    When I create a new Sale.
    Then make it Percentage discount type, active and sitewide.
    And verify that percentage sale price is applied to products for <country> website.
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

  Scenario Outline: Applying a discount coupon with active Fixed sale.
    When I create a new Sale.
    Then make it Fixed discount type, active and sitewide.
    And verify that fixed sale price is applied to products for <country> website.
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


#  Scenario Outline: Sale site wide discount.
#    When I create a new <country> Sale.
#    Then make it active, sitewide, <discount_type> discount type and <currency> currency.
#    And Regular and Sale prices are displayed on category pages.
#    And Regular and Sale prices are displayed on PDP.
#    And Sale price is displayed on cart and checkout.
#    And Sale price is charged to payment method.
#    And Sale price is displayed on order confirmation email.
#    But delete created sale.

#    Examples:
#      | country | currency | discount_type |
#      |         | ALL      | Percentage    |
#      | USA       | USD      | Percentage    |
#      | Australia | AUD      | Percentage    |


  Scenario: Delete all active Sale(s).
    When I go to Sales tab.
    Then deactivate active Sale(s).