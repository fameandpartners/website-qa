Feature: Footer.

  Background: Open 'Home' page.
    Given open "USA" home page.

    Scenario: Footer contains required links.
      Then footer contains links to:
        | Why Shop With Us  |
        | About Us          |
        | Fame Chain        |
        | From our CEO      |
        | Privacy Policy    |
        | Terms             |
        | Shipping Info     |
        | Returns Policy    |
        | Contact Us        |
        | FAQs              |
        | Size Guide        |
        | Track My Order    |
        | Best Sellers      |
        | What's New        |
        | Formal            |
        | Prom              |
        | View All Dresses  |

    Scenario: User can subscribe from footer.
      When I fill up subscribe form with random email.
      Then Click "Subscribe" button.
      And "Thanks for signing up" footer popup appears.
      Then it can be closed.
#      And user has been subscribed.

    Scenario: Footer contains social icons with linked urls to them.
      Then footer contains next social networks:
        | Instagram | https://instagram.com/FameandPartners     |
        | Facebook  | https://www.facebook.com/FameandPartners  |
        | Twitter   | https://twitter.com/FameandPartners       |
        | Pinterest | https://www.pinterest.com/fameandpartners |
        | Tumblr    | http://fameandpartners.tumblr.com         |
        | Polyvore  | http://fameandpartners.polyvore.com       |
