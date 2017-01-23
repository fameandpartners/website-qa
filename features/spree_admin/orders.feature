Feature: Orders.

#  Background: Create a new order.
#    Given As a customer I create a new order.
#      | Card number      | 5520000000000000  |
#      | Name on card     | Zaphod Beeblebrox |
#      | Expiration Month | 10                |
#      | Expiration Year  | 2020              |
#      | CVC              | 123               |

    Scenario: Order contains sidebar menu.
      Given I create a new guest user order.
        | Card number      | 5520000000000000  |
        | Name on card     | Zaphod Beeblebrox |
        | Expiration Month | 10                |
        | Expiration Year  | 2020              |
        | CVC              | 123               |
      Then I go to created guest user order.
      And order sidebar menu contains:
        | Order Details         |
        | Customer Details      |
        | Adjustments           |
        | Payments              |
        | Shipments             |
        | Return Authorizations |



  Scenario: 'Make status' can be changed.
      Given I create a new guest user order.
        | Card number      | 5520000000000000  |
        | Name on card     | Zaphod Beeblebrox |
        | Expiration Month | 10                |
        | Expiration Year  | 2020              |
        | CVC              | 123               |
      Then I go to created guest user order.
      And I can change "Make status" to:
        | PO Placed         |
        | PO Assigned       |
        | Fabric Assigned   |
        | Style Cutting     |
        | Making            |
        | QC                |
        | Shipped           |
        | Customer Feedback |

    Scenario: 'Shipped' make status for all order items will make the order available for return or exchange.
      Given as a customer I create a new order.
        | Card number      | 5520000000000000  |
        | Name on card     | Zaphod Beeblebrox |
        | Expiration Month | 10                |
        | Expiration Year  | 2020              |
        | CVC              | 123               |
      Then I go to created order.
      And I change make status to "Shipped".
      And "Return or exchange" is available for user.

#    Scenario: 'Shipped' make status will visibly change the order details page listing with an URL to the shipping method tracker

    Scenario: As admin I can add/remove adjustments for order.
      Given I create a new guest user order.
        | Card number      | 5520000000000000  |
        | Name on card     | Zaphod Beeblebrox |
        | Expiration Month | 10                |
        | Expiration Year  | 2020              |
        | CVC              | 123               |
      Then I go to created guest user order.
      Then I can add an adjustment for it.
      And be sure that it recalculated correctly.
      Then I can remove added adjustment for it.
      And be sure that it recalculated correctly after adjustment removing.
