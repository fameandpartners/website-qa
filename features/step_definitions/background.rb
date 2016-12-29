Given(/^I am on Home page\.$/) do
  on(ProductPage).visit_site_version(country: 'USA', url: '')
  # on(HomePage) do |page|
  #   page.visit_site_version(country: 'Australia', url: '')
  #   page.visit_site_version(country: 'USA', url: '')
  # end
end

Given(/^I am on 'Contact Us' page\.$/) do
  visit ContactUsPage
end

Given(/^As a customer I create a new order\.$/) do |table|
  on(MainBasePage).visit_site_version(country: 'USA', url: '/login')
  on(LoginPage) do |page|
    page.specify_registered_user(browser_name)
    page.submit_login
    session_data[browser_name][:is_authorized] = true
  end
  on(ProductPage) do |page|
    page.visit_site_version(country: 'USA', url: '/dresses/dress-kirrily-1100')
    page.open_dress_size
    page.select_dress_size('US 10')
    page.open_skirt_length
    page.select_skirt_length('PETITE'.downcase)
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
        sub_total:  sub_total,
        shipping: shipping,
        order_total: order_total
    }
    expect(@product_price).to eql(@prices[:sub_total])
    expect(@product_price).to eql(@prices[:order_total])
    page.place_my_order
  end
end

Given(/^open "([^"]*)" home page\.$/) do |site_ver|
  on(HomePage).visit_site_version(country: site_ver, url: '')
end

Given(/^I am on product page\.$/) do
  on(ProductPage).visit_site_version(country: 'USA', url: '/dresses/dress-kirrily-1100?color=spot')
end
