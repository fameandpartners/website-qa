Feature: Checkout process.
  As anonymous user I can buy a dress.
  As registered user I can buy a dress.

  @smoke
  Scenario: Successfully buy a dress as anonymous in USA.
    Given I am on USA 'Kirilly' dress.
    When I specify properties of dress:
      |Dress Size   |US 10  |
      |Skirt Length |PETITE |
    Then I add the dress to cart.
    And I fill in form fields with:
      | Email                   | overflow100182@gmail.com  |
      | First Name              | Lorem                     |
      | Last Name               | Ipsum                     |
      | Street Address          | Lorem street 8            |
      | Street Address (cont'd) | apt. 8                    |
      | City                    | Melbourne                 |
      | Phone Number            | 2255-4422                 |
      | Zipcode                 | 12345                     |
    Then I click 'Pay Securely'.
    And I fill in credit card information.
      | Card number      | 5520000000000000  |
      | Name on card     | Zaphod Beeblebrox |
      | Expiration Month | 10                |
      | Expiration Year  | 2050              |
      | CVC              | 123               |
    And I click on 'Place My Order' button.
    Then page with order number displayed.
    And it appears in 'Orders' admin area.






  Scenario Outline: User Validation Errors
    When I am on Connie dress page
    Then I select "<Site Version>" site version
    And I select "<Dress Size>" size
    And I select "<Skirt Length>" skirt length
    Then I should see add to cart link enabled.
    And I click on "ADD TO BAG" link.
    And I open the cart sidebar with the checkout button.
    And I click on "CHECKOUT" button.
    Then I fill in form fields with blank spaces:
      | First Name |
      | Last Name  |
    And I fill in form fields with:
      | Email                   | invalid-email |
      | Street Address          | Street X      |
      | Street Address (cont'd) | House Y       |
      | City                    | Melbourne     |
      | Phone Number            | 2255-4422     |
      | <Zipcode Label>         | 12345         |
    And I select "<State>" state
    And I select "<Country>" country
    And I click on "Pay Securely" button
    Then I should see "Customer E-Mail is invalid"
    Then I should see "First name can't be blank"
    Then I should see "Last name can't be blank"
    Examples:
      | Site Version | Country       | State      | Zipcode Label | Dress Size | Skirt Length |
      | Australia    | Australia     | Queensland | Postcode      | AU 14      | Standard     |
      | USA          | United States | California | Zipcode       | US 10      | Petite       |

  # TODO: Payment step require connection to PIN payment method. This should be kept like this, since we can detect PIN payments breaking changes!

  Scenario Outline: Successfully Buy a Dress
    When I am on Connie dress page
    Then I select "<Site Version>" site version
    And I select "<Dress Size>" size
    And I select "<Skirt Length>" skirt length
    Then I should see add to cart link enabled
    And I click on "ADD TO BAG" link
    # And I should see the cart sidebar with the checkout button
    # And I click on "CHECKOUT" button
    Then I select "<Country>" country and "<State>" state
    And I fill in form fields with:
      | Email                   | test@email.com |
      | First Name              | Roger          |
      | Last Name               | That           |
      | Street Address          | Street X       |
      | Street Address (cont'd) | House Y        |
      | City                    | Melbourne      |
      | Phone Number            | 2255-4422      |
      | <Zipcode Label>         | 12345          |
    And I click on "Pay Securely" button
    Then I should see "ADDITIONAL CUSTOM DUTY FEES MAY APPLY"
    And I click on "OK" button
    And I fill in credit card information:
      | Card number      | (CONFIG['user_email'])  |
      | Name on card     | Zaphod Beeblebrox |
      | Expiration Month | 10                |
      | Expiration Year  | 2050              |
      | CVC              | 123               |
    And I click on "Place My Order" button
    Then I should see my order placed, with "Connie" dress, "<Dress Size>" size and "<Dress Price>" price

    Examples:
      | Site Version | Country       | State      | Zipcode Label | Dress Size | Skirt Length | Dress Price |
      | Australia    | Australia     | Queensland | Postcode      | AU 14      | Petite       | 319.00      |
      | USA          | United States | California | Zipcode       | US 10      | Standard     | 289.00      |
      | Australia    | New Zealand   | Whanganui  | Postcode      | AU 8       | Tall         | 319.00      |