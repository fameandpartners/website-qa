require_relative 'spree_admin_pages/adm_modules/admin_header'
require_relative 'store_front_pages/modules/header'
require_relative 'store_front_pages/modules/product'
require_relative 'store_front_pages/modules/footer'

class MainBasePage
  include PageObject
  include Header
  include Product
  include Footer
  include AdminHeader

  CREDENTIALS = 'fandpstaging:auth4fandpstaging@'.freeze

  URLS = {
      home_us: "staging.fameandpartners.com",
      home_au: "staging.fameandpartners.com.au"
  }.freeze

  def visit_site_version(base_name: :home_us, country: nil, url:, basic_auth: false)
    if country
      case country
        when 'USA'
          base_name = :home_us
        when 'Australia'
          base_name = :home_au
      end
    end

    credentials = basic_auth ? CREDENTIALS : ''

    @browser.goto("https://#{credentials}#{URLS[base_name]}#{url}")
  end

end