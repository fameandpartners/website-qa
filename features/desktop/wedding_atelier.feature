Feature: Wedding Atelier application.

  @smoke
  Scenario Outline: As registered user I can login.
    When I open "<Country>" Wedding Atelier "Signin" form.
    Then I can specify user credentials.
    And sign in.
    Examples:
      | Country   |
      | USA       |
      | Australia |

  @smoke
  Scenario Outline: As anonymous user I can register and fill up profile.
    When I open "<Country>" Wedding Atelier "Signup" form.
    Then fill up signup form with random data.
    And click NEXT button.
    Then user can fill up <Country> "Size profile" page and go next.
    Then create wedding board.
    But send invitation later.
    And wedding board with countdown appears.
    Examples:
      | Country   |
      | USA       |
      | Australia |

#    Scenario: User can update wedding details.

  Scenario: As user I can update account details.
    When I open my wedding account.
    Then I can update:
      | First name    |
      | Last name     |
      | Email address |
      | Date of birth |
      | Passwords     |
    And specified data were updated.

  Scenario: As user I can update size profile.
    When I open my wedding size profile.
    Then I can change size profile parameters.
