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

    
