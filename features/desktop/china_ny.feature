Feature: China New Year.

  Scenario: As a customer during the CNY dates, I want to know about delivery delays.
    Given enable China New Year flag.
    Then I login as "user".
    When I am on "USA" product page.
    Then check CNY delivery time is "Estimated delivery, 17 - 20 business days".
    And open cart.
    And cart contains "CNY delay delivery" message.
      """
      We're experiencing a high order volume right now, so it's taking longer than usual to handcraft each made-to-order garment. We'll be back to our normal timeline of 7-10 days soon.
      """
    Then specify random dress size and growth for the dress.
    And add a dress to cart.
#      Then check CNY delivery time period on checkout.
#      """
#      Due to high order volume, it's taking us a bit longer to handcraft each garment. Our delivery timeline of 7-10 days should resume soon.
#      """
    But complete order.
      | Card number      | 5520000000000000  |
      | Name on card     | Zaphod Beeblebrox |
      | Expiration Month | 10                |
      | Expiration Year  | 2020              |
      | CVC              | 123               |
    And order confirm page contains "17 - 20" delivery days.
    Then expected delivery date in profile increased on 20 days.
#    And check Expected delivery date in email.

  Scenario: Disable CNY.
    Given I disable CNY flag.