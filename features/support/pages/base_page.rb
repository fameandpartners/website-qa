require 'net/http'
require 'uri'

require_relative 'spree_admin_pages/adm_modules/admin_header'
require_relative 'store_front_pages/modules/header'
require_relative 'store_front_pages/modules/product'
require_relative 'store_front_pages/modules/footer'
require_relative('../../../features/support/hooks_helper')

include HooksHelper

class MainBasePage
  include PageObject
  include Header
  include Product
  include Footer
  include AdminHeader
  
  CREDENTIALS = 'fandpstaging:auth4fandpstaging'.freeze
  USA_SIZES = ["US 0","US 2","US 4","US 6","US 8","US 10","US 12","US 14","US 16","US 18","US 20","US 22"].freeze
  AUS_SIZES = ["AU 4","AU 6","AU 8","AU 10","AU 12","AU 14","AU 16","AU 18","AU 20","AU 22","AU 24","AU 26"].freeze
  HEIGHT = %w["147cm", "150cm", "152cm", "155cm", "157cm", "160cm", "163cm", "165cm", "167cm", "170cm", "173cm", "175cm",
            "178cm", "180cm", "183cm", "185cm", "188cm", "190cm", "193cm"].freeze
  LENGTH = %w["petite", "standard", "tall"].freeze

  URLS = {
      home_us: "#{test_server}.fameandpartners.com",
      home_au: "#{test_server}.fameandpartners.com.au"
  }.freeze

  def visit_site_version(base_name: :home_us, country: nil, url:, basic_auth: false, response_code: false)
    if country
      case country
        when 'USA'
          base_name = :home_us
        when 'Australia'
          base_name = :home_au
      end
    end

    credentials = basic_auth ? "#{CREDENTIALS}@" : ''
    site_url = "https://#{credentials}#{URLS[base_name]}#{url}"

    @browser.goto(site_url)
    if basic_auth
      close_promo_offer_popup
      close_first_shopper_popup
    end
    if response_code
      page_status_code(site_url)
    end
  end


  def page_status_code(url)
    creds = CREDENTIALS.split(':')
    uri = URI.parse(url)

    connection = Net::HTTP.new(uri.host, uri.port)
    connection.use_ssl = true
    connection.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth(creds.first, creds.last)

    response = connection.request(request)
    response.code
  end

  def close_promo_offer_popup
    begin
      self.div_element(xpath: '//a[@data-click="nothing"]//div[contains(text(),"just browsing")]').when_present.click
      self.div_element(xpath: '//a[@data-click="nothing"]//div[contains(text(),"just browsing")]').wait_while_present
    rescue Watir::Wait::TimeoutError
      false
    end
  end

  def close_first_shopper_popup
    begin
      self.link_element(css: '#bx-close-inside-636586').when_present.click
      self.link_element(css: '#bx-close-inside-636586').wait_while_present
    rescue Watir::Wait::TimeoutError
      false
    end
  end
end