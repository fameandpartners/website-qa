Feature: Checkout process.
  As anonymous user I can buy a dress in USA or Australia.
  As registered user I can buy a dress in USA or Australia.

  @smoke
  Scenario Outline: As an anonymous user I can buy a dress.
    When I go to "<Country>" site version.
    Then specify random dress size and growth for the dress.
#    Then specify "<Dress Size>" dress Size and "<Height & Hemline>" skirt length of the dress.
    And add the dress to cart.
    Then I fill in form fields with:
      | Email                   | anonymous_user@fameandpartners.com  |
      | First Name              | Lorem                               |
      | Last Name               | Ipsum                               |
      | Street Address          | Lorem street 8                      |
      | Street Address (contd)  | apt. 8                              |
      | Country                 | <Ship Country>                      |
      | State                   | <State>                             |
      | City                    | <City>                              |
      | Phone Number            | 2255-4422                           |
      | Zipcode                 | 12345                               |
    And set "This is also my billing address".
    Then I click 'Pay Securely'.
    And fill in credit card information.
      | Card number      | 5520000000000000  |
      | Name on card     | Zaphod Beeblebrox |
      | Expiration Month | 10                |
      | Expiration Year  | 2020              |
      | CVC              | 123               |
    But check "Order summary".
    And click on 'Place My Order' button.
    Then "Thanks for your order!" page with order number displayed.
    And it appears in "<Country>" orders admin area.

    Examples:
      | Country   | Ship Country  | State           | City    | Dress Size | Height & Hemline |
      | USA       | United States | Washington      | Seattle | US 10      | PETITE           |
      | Australia | Australia     | New South Wales | Sydney  | AU 6       | STANDARD         |

  @smoke
  Scenario Outline: As a registered user I can buy a dress.
    When I go to "<Country>" site version.
    And I login as user.
    Then specify random dress size and growth for the dress.
#    Then specify "<Dress Size>" dress Size and "<Height & Hemline>" skirt length of the dress.
    And add the dress to cart.
    Then I fill in form fields with:
      | Email                   | auto.user.fm@gmail.com    |
      | First Name              | Auto                      |
      | Last Name               | User                      |
      | Street Address          | Lorem street 8            |
      | Street Address (contd)  | apt. 8                    |
      | Country                 | <Ship Country>            |
      | State                   | <State>                   |
      | City                    | <City>                    |
      | Phone Number            | 2255-4422                 |
      | Zipcode                 | 12345                     |
    And set "This is also my billing address".
    Then I click 'Pay Securely'.
    And fill in credit card information.
      | Card number      | 5520000000000000  |
      | Name on card     | Zaphod Beeblebrox |
      | Expiration Month | 10                |
      | Expiration Year  | 2020              |
      | CVC              | 123               |
    But check "Order summary".
    And click on 'Place My Order' button.
    Then "Thanks for your order!" page with order number displayed.
    And there is also on "My Orders" <Country> page.
    And it appears in "<Country>" orders admin area.

    Examples:
      | Country   | Ship Country  | State           | City    | Dress Size | Height & Hemline |
      | USA       | United States | Washington      | Seattle | US 10      | PETITE           |
      | Australia | Australia     | New South Wales | Sydney  | AU 6       | STANDARD         |

  @smoke
  Scenario Outline: As an anonymous user I can buy a dress with an extra $30 fee charge shipping.
    When I go to "<Country>" site version.
    Then specify random dress size and growth for the dress.
#    Then specify "<Dress Size>" dress Size and "<Height & Hemline>" skirt length of the dress.
    And add the dress to cart.
    And I fill in form fields with:
      | Email                   | anonymous_user@fameandpartners.com    |
      | First Name              | Anonymous                             |
      | Last Name               | User                                  |
      | Street Address          | Lorem street 8                        |
      | Street Address (contd)  | apt. 8                                |
      | Country                 | <Ship Country>                        |
      | State                   | <State>                               |
      | City                    | <City>                                |
      | Phone Number            | 2255-4422                             |
      | Zipcode                 | 12345                                 |
    And set "This is also my billing address".
    And confirm custom duty fees.
    Then I click 'Pay Securely'.
    And fill in credit card information.
      | Card number      | 5520000000000000  |
      | Name on card     | Zaphod Beeblebrox |
      | Expiration Month | 10                |
      | Expiration Year  | 2020              |
      | CVC              | 123               |
    But check "Order summary" with custom duty fees.
    And click on 'Place My Order' button.
    Then "Thanks for your order!" page with order number displayed.
    And it appears in "<Country>" orders admin area.

    Examples:
      | Country   | Ship Country  | State   | City      | Dress Size | Height & Hemline |
      | USA       | Austria       | Wien    | Ayia Napa | US 10      | PETITE           |
      | Australia | China         | Shanxi  | Taiyuan   | AU 6       | STANDARD         |

  @smoke
  Scenario Outline: As a registered user I can buy a dress with an extra $30 fee charge shipping.
    When I go to "<Country>" site version.
    And I login as user.
    Then specify random dress size and growth for the dress.
#    Then specify "<Dress Size>" dress Size and "<Height & Hemline>" skirt length of the dress.
    And add the dress to cart.
    And I fill in form fields with:
      | Email                   | auto.user.fm@gmail.com    |
      | First Name              | Auto                      |
      | Last Name               | User                      |
      | Street Address          | Lorem street 8            |
      | Street Address (contd)  | apt. 8                    |
      | Country                 | <Ship Country>            |
      | State                   | <State>                   |
      | City                    | <City>                    |
      | Phone Number            | 2255-4422                 |
      | Zipcode                 | 12345                     |
    And set "This is also my billing address".
    And confirm custom duty fees.
    Then I click 'Pay Securely'.
    And fill in credit card information.
      | Card number      | 5520000000000000  |
      | Name on card     | Zaphod Beeblebrox |
      | Expiration Month | 10                |
      | Expiration Year  | 2020              |
      | CVC              | 123               |
    But check "Order summary" with custom duty fees.
    And click on 'Place My Order' button.
    Then "Thanks for your order!" page with order number displayed.
    And there is also on "My Orders" <Country> page.
    And it appears in "<Country>" orders admin area.

    Examples:
      | Country   | Ship Country  | State   | City      | Dress Size | Height & Hemline |
      | USA       | Austria       | Wien    | Ayia Napa | US 10      | PETITE           |
      | Australia | China         | Shanxi  | Taiyuan   | AU 6       | STANDARD         |

  @smoke #new size profile done
  Scenario: As a user I can buy a dress with a discount coupon.
    When I go to "USA" site version.
    Then specify random dress size and growth for the dress.
    And add the dress to cart.
    Then I fill in form fields with:
      | Email                   | anonymous_user@fameandpartners.com  |
      | First Name              | Lorem                               |
      | Last Name               | Ipsum                               |
      | Street Address          | Lorem street 8                      |
      | Street Address (contd)  | apt. 8                              |
      | Country                 | United States                       |
      | State                   | Washington                          |
      | City                    | Seattle                             |
      | Phone Number            | 2255-4422                           |
      | Zipcode                 | 12345                               |
    And set "This is also my billing address".
    And apply a coupon for 25% discount.
    Then I click 'Pay Securely'.
    And fill in credit card information.
      | Card number      | 5520000000000000  |
      | Name on card     | Zaphod Beeblebrox |
      | Expiration Month | 10                |
      | Expiration Year  | 2020              |
      | CVC              | 123               |
    But check "Order summary" with a discount coupon.
    And click on 'Place My Order' button.
    Then "Thanks for your order!" page with order number displayed.
    And it appears in "USA" orders admin area.

    #new size profile done
  Scenario: As a user I can delete a dress from checkout.
    When I go to "USA" site version.
    Then specify random dress size and growth for the dress.
    And add the dress to cart.
    Then I can delete the dress from cart.
    But "Oops, looks like your bag is empty." popup appears.
    And I can continue shopping.


