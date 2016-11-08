Feature: Checkout process.
  As anonymous user I can buy a dress in USA or Australia.
  As registered user I can buy a dress in USA or Australia.

  @smoke
  Scenario Outline: As an anonymous user I can buy a dress.
    When I go to "<Country>" site version.
    Then specify "<Dress Size>" dress Size and "<Skirt Length>" skirt length of the dress.
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
      | Country   | Ship Country  | State           | City    | Dress Size | Skirt Length |
      | USA       | United States | Washington      | Seattle | US 10      | PETITE       |
      | Australia | Australia     | New South Wales | Sydney  | AU 6       | STANDARD     |

  @smoke
  Scenario Outline: As a registered user I can buy a dress.
    When I go to "<Country>" site version.
    And I login as user.
    Then specify "<Dress Size>" dress Size and "<Skirt Length>" skirt length of the dress.
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
      | Country   | Ship Country  | State           | City    | Dress Size | Skirt Length |
      | USA       | United States | Washington      | Seattle | US 10      | PETITE       |
      | Australia | Australia     | New South Wales | Sydney  | AU 6       | STANDARD     |

  @smoke
  Scenario Outline: As an anonymous user I can buy a dress shipping to Cyprus with an extra $30 fee charge.
    When I go to "<Country>" site version.
    Then specify "<Dress Size>" dress Size and "<Skirt Length>" skirt length of the dress.
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
      | Country   | Ship Country  | State   | City      | Dress Size | Skirt Length |
      | USA       | Cyprus        | Larnaka | Ayia Napa | US 10      | PETITE       |
      | Australia | Cyprus        | Larnaka | Ayia Napa | AU 6       | STANDARD     |

  @smoke
  Scenario Outline: As a registered user I can buy a dress shipping to Cyprus with an extra $30 fee charge.
    When I go to "<Country>" site version.
    And I login as user.
    Then specify "<Dress Size>" dress Size and "<Skirt Length>" skirt length of the dress.
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
      | Country   | Ship Country  | State   | City      | Dress Size | Skirt Length |
      | USA       | Cyprus        | Larnaka | Ayia Napa | US 10      | PETITE       |
      | Australia | Cyprus        | Larnaka | Ayia Napa | AU 6       | STANDARD     |

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Scenario Outline: As a user I can buy a dress with a discount coupon.
    When I go to "<Country>" site version.
    Then specify "<Dress Size>" dress Size and "<Skirt Length>" skirt length of the dress.
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
    And it appears in "<Country>" orders admin area.

    Examples:
      | Country   | Ship Country  | State           | City    | Dress Size | Skirt Length |
      | USA       | United States | Washington      | Seattle | US 10      | PETITE       |
      | Australia | Australia     | New South Wales | Sydney  | AU 6       | STANDARD     |





#  Scenario Outline: User validation errors fields.
#    When I am on Connie dress page
#    Then I select "<Site Version>" site version
#    And I select "<Dress Size>" size
#    And I select "<Skirt Length>" skirt length
#    Then I should see add to cart link enabled.
#    And I click on "ADD TO BAG" link.
#    And I open the cart sidebar with the checkout button.
#    And I click on "CHECKOUT" button.
#    Then I fill in form fields with blank spaces:
#      | First Name |
#      | Last Name  |
#    And I fill in form fields with:
#      | Email                   | invalid-email |
#      | Street Address          | Street X      |
#      | Street Address (cont'd) | House Y       |
#      | City                    | Melbourne     |
#      | Phone Number            | 2255-4422     |
#      | <Zipcode Label>         | 12345         |
#    And I select "<State>" state
#    And I select "<Country>" country
#    And I click on "Pay Securely" button
#    Then I should see "Customer E-Mail is invalid"
#    Then I should see "First name can't be blank"
#    Then I should see "Last name can't be blank"
#    Examples:
#      | Site Version | Country       | State      | Zipcode Label | Dress Size | Skirt Length |
#      | Australia    | Australia     | Queensland | Postcode      | AU 14      | Standard     |
#      | USA          | United States | California | Zipcode       | US 10      | Petite       |

