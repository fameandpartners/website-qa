Feature: Return or Exchange.
  As a user I can request for Return or Exchange.
  As a user I can Keep a dress.
  As a user I can Return a dress.
  As a user I can Exchange a dress.

  Scenario: User can open Return or Exchange page.
    Given as a customer I buy a dress.
      | Card number      | 5520000000000000  |
      | Name on card     | Zaphod Beeblebrox |
      | Expiration Month | 10                |
      | Expiration Year  | 2020              |
      | CVC              | 123               |
    Then I open created order.
    And I change make status to "Shipped".
    Then user can request for "Return or exchange".
    And all data of selected dress are correct.