Feature: Contact Us.

  Background: Open 'Contact Us' page.
    Given I am on Home page.

    Scenario: User can open 'Contact Us' page.
      When I open 'Contact Us' page.
      Then there are all required 'Contact Us' controls.

    Scenario Outline: User can send an enquiry.
      When I open 'Contact Us' page.
      Then I fill in contact info with:
        | First Name    | Lorem                   |
        | Last Name     | Ipsum                   |
        | Email         | auto.user.fm@gmail.com  |
        | Country code  | Australia (+61)         |
        | Phone number  | 741-23-6985             |
      And I select "<Help>" type and select "<Category>" category.
      Then I describe my enquiry.
      And submit my enquiry.

      Examples:
        | Help              | Category                  |
        | Making a purchase | Delivery                  |
        | Making a purchase | Product                   |
        | Making a purchase | Styling Tips              |
        | Making a purchase | Customization             |
        | Making a purchase | Size                      |
        | Existing orders   | Order Status              |
        | Existing orders   | Change Existing Order     |
        | Existing orders   | Issue with Order          |
        | Existing orders   | Returns & Exchanges       |
        | Other enquiries   | Site Issues               |
        | Other enquiries   | Book a Style Consultation |
        | Other enquiries   | Retailer Questions        |
        | Other enquiries   | None of These Apply to Me |
        | Other enquiries   | Fashion "IT" Girl         |