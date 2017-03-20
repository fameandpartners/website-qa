Feature: Footer.

  Background: Open 'Home' page.
    Given open "USA" home page.

    Scenario: Footer contains required links.
      Then footer contains links to:
        | link_title        | link_url                          |
        | Why Shop With Us  | /why-us                           |
        | About Us          | /about                            |
        | Fame Society      | /fame-society-application         |
        | From our CEO      | /from-our-ceo                     |
        | Privacy Policy    | /privacy                          |
        | Terms             | /terms                            |
        | Shipping Info     | /faqs#collapse-delivery-how-long  |
        | Returns Policy    | /faqs#collapse-returns-policy     |
        | Contact Us        | /contact                          |
        | FAQs              | /faqs                             |
        | Size Guide        | /size-guide                       |
        | Track My Order    | /faqs#collapse-orders-track       |
        | Best Sellers      | /dresses/best-sellers             |
        | What's New        | /dresses?order=newest             |
        | Formal            | /dresses/formal                   |
        | Prom              | /dresses/prom                     |
        | View All Dresses  | /dresses                          |

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
