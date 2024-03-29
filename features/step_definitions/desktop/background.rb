Given(/^I am on Home page\.$/) do
  on(HomePage).visit_site_version(country: 'USA', url: '', basic_auth: true)
end

Given(/^I am on 'Contact Us' page\.$/) do
  on(MainBasePage).visit_site_version(country: 'USA', url: '/contact', basic_auth: true)
end

Given(/^as a customer I create a new order\.$/) do |table|
  on(MainBasePage).visit_site_version(country: 'USA', url: '', basic_auth: true)
  on(MainBasePage).visit_site_version(country: 'USA', url: '/login')
  on(LoginPage) do |page|
    page.specify_registered_user(browser_name)
    page.submit_login
    session_data[browser_name][:is_authorized] = true
  end
  on(ProductPage) do |page|
    page.visit_site_version(country: 'USA', url: '/dresses/dress-eclectic-love-dress-1114?color=rosewater-floral')

    page.open_size_profile
    page.change_metric('cm')
    random_growth = page.get_random_growth.to_i
    page.specify_your_growth(random_growth)
    puts "Specified random growth is: #{random_growth}cm"
    random_size = page.get_random_dress_size('USA')
    puts "Random size is: #{random_size}"
    page.specify_random_size(random_size)
    page.save_pdp_size_profile

    @product_price = page.divProductPrice_element.text.gsub(/[^\d\.]/, '').to_f
    puts "Product price is: #{@product_price}"
    page.add_to_bag
  end
  on(CheckOutPage) do |page|
    page.specify_phone_num(phone_num: '2255-4422')
    page.select_country(country: 'United States')
    page.specify_street_address(street: 'Lorem street 8')
    page.specify_street_address_contd(street_cnd: 'apt. 8')
    page.specify_city(city: 'Seattle')
    page.zipcode(zipcode: '12345')
    page.select_state(state: 'Washington')
    page.select_ship_address(true)
    @order_number = page.div_element(xpath: "//div[contains(@class,'hidden')]//div[contains(text(),'Number')]").text.scan(/[A-Z]\d{,9}$/).first
    puts "Order number is: #{@order_number}"
    page.pay_securely
    data = table.rows_hash
    page.close_fee_popup
    page.fill_in_credit(data)
    sub_total = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//p[contains(text(),'Sub Total')]//span").text.gsub(/[^\d\.]/, '').to_f
    shipping = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//p[contains(text(),'Shipping')]//span").text.gsub(/[^\d\.]/, '').to_f
    order_total = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//p[contains(text(),'Order Total')]//span").text.gsub(/[^\d\.]/, '').to_f
    puts <<-EOS
      Sub Total: #{sub_total}
      Shipping: #{shipping}
      Order Total: #{order_total}
    EOS
    @prices = {
        sub_total: sub_total,
        shipping: shipping,
        order_total: order_total
    }
    expect(@product_price).to eql(@prices[:sub_total])
    expect(@product_price).to eql(@prices[:order_total])
    page.place_my_order
    page.h3_element(xpath: "//h3[text()='Order # #{@order_number}']").when_present(30)
  end
end

Given(/^open "([^"]*)" home page\.$/) do |site_ver|
  on(HomePage).visit_site_version(country: site_ver, url: '', basic_auth: true)
end


Given(/^open admin users page\.$/) do
  on(LoginPage) do |page|
    page.visit_site_version(country: 'USA', url: '/login', basic_auth: true)
    page.specify_credentials(CONFIG['spree_admin'], CONFIG['admin_pwd'])
    page.submit_login
    page.visit_site_version(country: 'USA', url: '/admin/users')
  end
end

Given(/^I login to admin area\.$/) do
  on(LoginPage) do |page|
    page.visit_site_version(country: 'USA', url: '/login', basic_auth: true)
    page.specify_credentials(CONFIG['spree_admin'], CONFIG['admin_pwd'])
    page.submit_login
  end
end


Given(/^enable China New Year flag\.$/) do
  on(HomePage) do |page|
    page.visit_site_version(country: 'USA', url: '', basic_auth: true)
    page.click_my_account

    # page.visit_site_version(country: 'USA', url: '/login')
  end
  on(LoginPage) do |page|
    page.specify_credentials(CONFIG['spree_admin'], CONFIG['admin_pwd'])
    page.submit_login
    page.visit_site_version(country: 'USA', url: '/fame_admin/backend/features')
  end
  on(FameAdminPage) do |page|
    page.cny_flag('enable')
    page.expire_cache
    page.visit_site_version(country: 'USA', url: '/logout')
  end
end


Given(/^I login as "([^"]*)"\.$/) do |user_role|
  on(LoginPage) do |page|
    session_data[browser_name][:is_authorized] = true
    page.visit_site_version(country: 'USA', url: '', basic_auth: true)
    page.visit_site_version(country: 'USA', url: '/login')
    case user_role
      when 'admin'
        page.specify_credentials(CONFIG['spree_admin'], CONFIG['admin_pwd'])
      when 'user'
        page.specify_registered_user(browser_name)
    end
    page.submit_login
  end
end

Given(/^as admin I disable China New Year feature flag\.$/) do
  on(HomePage) do |page|
    page.visit_site_version(country: 'USA', url: '', basic_auth: true)
    page.visit_site_version(country: 'USA', url: '/login')
  end
  on(LoginPage) do |page|
    page.specify_credentials(CONFIG['spree_admin'], CONFIG['admin_pwd'])
    page.submit_login
    page.visit_site_version(country: 'USA', url: '/fame_admin/backend/features')
  end
  on(FameAdminPage) do |page|
    page.cny_flag('disable')
    page.expire_cache
    page.visit_site_version(country: 'USA', url: '/logout')
  end
end

Given(/^I am on Wedding Atelier page\.$/) do
  on(HomePage) do |page|
    page.visit_site_version(country: 'USA', url: '', basic_auth: true)
    page.visit_site_version(country: 'Australia', url: '', basic_auth: true)
  end
end


Given(/^I disable CNY flag\.$/) do
  on(HomePage) do |page|
    page.visit_site_version(country: 'USA', url: '/logout', basic_auth: true)
    page.visit_site_version(country: 'USA', url: '/login')
    # page.visit_site_version(country: 'USA', url: '', basic_auth: true)
    # page.click_my_account
  end
  on(LoginPage) do |page|
    page.specify_credentials(CONFIG['spree_admin'], CONFIG['admin_pwd'])
    page.submit_login
    page.visit_site_version(country: 'USA', url: '/fame_admin/backend/features')
  end
  on(FameAdminPage) do |page|
    page.cny_flag('disable')
    page.expire_cache
    page.visit_site_version(country: 'USA', url: '/logout')
  end
end


Given(/^I am on product page\.$/) do
  on(LoginPage).visit_site_version(country: 'USA', url: CONFIG['base_dress'], basic_auth: true)
end