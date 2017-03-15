Feature: Free Styling Session.
  As user I can book me in to Free Styling Session.

  Background: Open Free Styling Session page.
    Given I am on Home page.

    @smoke
    Scenario: User can book for Free Styling Session page.
      Given I have user's data:
        | Full Name    | Lorem Ipsum         |
        | Phone number | +38 (044) 911 91 91 |
      When I open "Free Styling Session" page.
      Then I can book via:
        | session_type |
        | Email        |
        | Video Chat   |
        | Phone        |

    Scenario: Check logic visibility of free Styling session form elements.
      When I open "Free Styling Session" page.
      Then next check logic visibility of elements:
        | session_type | full_name | email_address | phone_number | timezone | preferred_time |
        | Email        | true      | true          |              |          |                |
        | Video Chat   | true      | true          |              | true     | true           |
        | Phone        | true      | true          | true         | true     | true           |