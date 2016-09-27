#~~~ Successfully buy a dress as registered user.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Then(/^I fill in form fields with:$/) do |table|
  on(CheckOutPage) do |page|
    data = table.rows_hash
    if @is_authorized == false
      page.specify_email(email: data['Email'])
      page.specify_first_name(fname: data['First Name'])
      page.specify_last_name(lname: data['Last Name'])
    end
    page.specify_street_address(street: data['Street Address'])
    page.specify_street_address_contd(street_cnd: data['Street Address (contd)'])
    page.select_country(country: data['Country'])
    page.zipcode(zipcode: data['Zipcode'])
    page.specify_city(city: data['City'])
    page.specify_phone_num(phone_num: data['Phone Number'])
    page.select_state(state: data['State'])
  end
end

And(/^fill in credit card information\.$/) do |table|
  on(CheckOutPage) do |page|
    data = table.rows_hash
    page.close_fee_popup
    page.fill_in_credit(data)
  end
end

Then(/^I click 'Pay Securely'\.$/) do
  on(CheckOutPage) do |page|
    @order_number = page.paragraph_element(xpath: "//div[contains(@class,'hidden')]//p[@class='order-number']").text
    page.pay_securely
  end
end

And(/^click on 'Place My Order' button\.$/) do
  on(CheckOutPage) do |page|
    page.place_my_order
  end
end

Then(/^"([^"]*)" page with order number displayed\.$/) do |message|
  on(CheckOutPage) do |page|
    page.h1_element(xpath: "//h1[text()='#{message}']").when_present
    # page.wait_until(30) { page.text.include? message }
    @complete_order_number = page.h3_element(xpath: "//h3[@class='order-number']").text.scan(/[A-Z]\d{,9}$/).first
    expect(@order_number).to eql(@complete_order_number)
  end
end

And(/^it appears in 'Orders' admin area\.$/) do
  visit LogoutPage
  visit LoginPage
  sleep 2
  on(LoginPage) do |page|
    page.specify_credentials(CONFIG['admin'],CONFIG['admin_pwd'])
    page.submit_login
    # if page.txtEmail_element.visible?
    #   page.specify_credentials(CONFIG['admin'],CONFIG['admin_pwd'])
    #   page.submit_login
    # end
  end
  visit OrdersPage
  on(OrdersPage) do |page|
    page.specify_search_order(@complete_order_number)
    page.filter_results
    page.link_element(text: @complete_order_number).when_present.click
    page.h1_element(xpath: "//h1[contains(text(),'#{@complete_order_number}')]").when_present
    admin_sub_total = page.span_element(xpath: "//tr[@id='subtotal-row']//td[@class='total']//span").text.gsub(/[^\d\.]/, '').to_f
    admin_shipping = page.span_element(xpath: "//*[@id='order-charges']//td[@class='total']/span").text.gsub(/[^\d\.]/, '').to_f
    admin_order_total = page.span_element(xpath: "//td[@id='order-total']/span").text.gsub(/[^\d\.]/, '').to_f
    expect(@prices[:sub_total]).to eql(admin_sub_total)
    expect(@prices[:shipping]).to eql(admin_shipping)
    expect(@prices[:order_total]).to eql(admin_order_total)

  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Successfully buy a dress as registered user.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
And(/^there is also on "My Orders" page\.$/) do
  if @country_version == 'Australia'
    @browser.goto(CONFIG['base_url_au']+'/user_orders')
  else
    visit UserOrdersPage
  end

  on(UserOrdersPage) do |page|
    page.tblOrdersTable_element.when_present
    expect(page.link_element(xpath: "//a[text()='#{@complete_order_number}']").visible?).to be_truthy
  end
end

And(/^select "([^"]*)"\.$/) do |shipment|
  on(CheckOutPage) do |page|
    page.select_ship_address(shipment)
  end
end

And(/^confirm custom duty fees\.$/) do
  on(CheckOutPage).confirm_custom_duty_fees(true)
end

But(/^check "Order summary"\.$/) do
  on(CheckOutPage) do |page|
    sub_total = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//p[contains(text(),'Sub Total')]//span").text.gsub(/[^\d\.]/, '').to_f
    shipping = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//p[contains(text(),'Shipping')]//span").text.gsub(/[^\d\.]/, '').to_f
    order_total = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//strong[contains(text(),'Total')]//span").text.gsub(/[^\d\.]/, '').to_f
    @prices = {
        sub_total:  sub_total,
        shipping: shipping,
        order_total: order_total
    }
    expect(@product_price).to eql(@prices[:sub_total])
    expect(@product_price).to eql(@prices[:order_total])
  end
end

But(/^check "Order summary" with custom duty fees\.$/) do
  on(CheckOutPage) do |page|
    sub_total = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//p[contains(text(),'Sub Total')]//span").text.gsub(/[^\d\.]/, '').to_f
    shipping = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//p[contains(text(),'Shipping')]//span").text.gsub(/[^\d\.]/, '').to_f
    order_total = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//strong[contains(text(),'Total')]//span").text.gsub(/[^\d\.]/, '').to_f
    @prices = {
        sub_total:  sub_total,
        shipping: shipping,
        order_total: order_total
    }
    expect(@product_price).to eql(@prices[:sub_total])
    # @order_total_fees=@prices[:sub_total]+@prices[:shipping]
    order_total_fee = @prices[:sub_total]+@prices[:shipping]
    puts order_total_fee
    expect(@prices[:order_total]).to eql(order_total_fee)
  end
end