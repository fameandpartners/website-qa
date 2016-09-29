require_relative 'admin_pages/adm_modules/admin_header'
require_relative 'store_front_pages/modules/header'
require_relative 'store_front_pages/modules/product'
require_relative 'store_front_pages/modules/footer'

class BasePage
  include PageObject
  include Header
  include Product
  include Footer
  include AdminHeader


  URLS = {
      home_us: "https://fandpstaging:auth4fandpstaging@staging.fameandpartners.com",
      home_au: "https://fandpstaging:auth4fandpstaging@staging.fameandpartners.com.au"
  }.freeze

  def visit_site_version(base_name: :home_us, country: nil, url:)
    if country
      case country
        when 'USA'
          base_name = :home_us
        when 'Australia'
          base_name = :home_au
      end
    end
    @browser.goto("#{URLS[base_name]}#{url}")
  end

end