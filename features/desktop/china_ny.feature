Feature: China New Year.


  Background: Enable China New Year flag.
    Given enable China New Year flag.

    Scenario: As a customer during the CNY dates, I want to know about delivery delays.
      Given I login as "user".
      When I am on product page.
      Then check CNY delivery time is "Estimated delivery, 2 weeks".
      And open cart.
      And cart contains "CNY delay delivery" message.
      """
      We're experiencing a high order volume right now, so it's taking longer than usual to handcraft each made-to-order garment. We'll be back to our normal timeline of 7-10 days soon.
      """
      Then specify "US 10" dress Size and "STANDARD" skirt length of the dress.
      And add a dress to cart.
      Then check CNY delivery time on checkout.
      """
      Due to high order volume, it's taking us a bit longer to handcraft each garment. Our delivery timeline of 7-10 days should resume soon.
      """
      But complete order.
        | Card number      | 5520000000000000  |
        | Name on card     | Zaphod Beeblebrox |
        | Expiration Month | 10                |
        | Expiration Year  | 2020              |
        | CVC              | 123               |
      And check estimated delivery on order confirm page.
      Then check Expected delivery date in profile.
      And check Expected delivery date in email.