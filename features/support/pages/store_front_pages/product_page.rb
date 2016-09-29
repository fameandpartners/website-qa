require_relative '../../pages/store_front_pages/modules/header'
require_relative '../../pages/store_front_pages/modules/product'

class ProductPage
  include PageObject
  include Header
  include Product

  URLS = {
      prod_us: "https://fandpstaging:auth4fandpstaging@staging.fameandpartners.com",
      prod_au: "https://fandpstaging:auth4fandpstaging@staging.fameandpartners.com.au"
  }.freeze

  #page_url(URLS[:prod_us]+'/dresses/dress-kirrily-1100')

  def goto(base_name: :prod_us, country: nil, url:)
    if country
      case country
        when 'USA'
          base_name = :prod_us
        when 'Australia'
          base_name = :prod_au
      end
    end
    @browser.goto("#{URLS[base_name]}#{url}")
  end



end