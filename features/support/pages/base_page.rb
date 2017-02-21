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
  USA_SIZES = ["US 0","US 2","US 4","US 6","US 8","US 10","US 12","US 14","US 16","US 18","US 20","US 22"].freeze
  AUS_SIZES = ["AU 4","AU 6","AU 8","AU 10","AU 12","AU 14","AU 16","AU 18","AU 20","AU 22","AU 24","AU 26"].freeze
  HEIGHT = ["147cm","150cm","152cm","155cm","157cm","160cm","163cm","165cm","167cm","170cm","173cm","175cm","178cm","180cm","183cm","185cm","188cm","190cm","193cm","196cm"].freeze

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