Feature: Footer.

  Background: Open 'Home' page.
    Given open "USA" home page.

    Scenario: Footer contains required links.
      Then footer contains links to:
        | Why Shop With Us  |
        | About Us          |
        | Growth Plan       |
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
        | Made in 48 Hours  |
        | Formal            |
        | Prom              |
        | View All Dresses  |

    Scenario: User can subscribe from footer.
      When I fill up subscribe form.
      Then Click "Subscribe" button.
      And "Thanks for signing up" footer popup appears.
      And it can be closed.