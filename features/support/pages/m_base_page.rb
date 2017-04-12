# require_relative 'spree_admin_pages/adm_modules/admin_header'
require_relative 'mobile_pages/m_modules/m_header'
require_relative 'mobile_pages/m_modules/m_product'
require_relative 'mobile_pages/m_modules/m_footer'
require 'net/http'
require 'uri'

class MobileBasePage
  include PageObject
  include MobileHeader
  include MobileProduct
  include MobileFooter
  # include AdminHeader


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
    
    site_url = "#{URLS[base_name]}#{url}"
    puts "STATUS: (#{page_status_code(site_url)}) for page '#{site_url}'"
    
    @browser.goto(site_url)
    site_url
  end

  def page_status_code(url)
    uri = URI.parse(url)

    connection = Net::HTTP.new(uri.host, uri.port)
    connection.use_ssl = true

    request = Net::HTTP::Get.new(uri.request_uri)
    response = connection.request(request)
    response.code
  end

end