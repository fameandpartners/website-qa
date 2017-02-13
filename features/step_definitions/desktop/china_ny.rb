Then(/^check CNY delivery time is "([^"]*)"\.$/) do |pdp_delivery|
  on(ProductPage) do |page|
    exp_delivery = page.list_item_element(xpath:"//li[contains(text(),'Estimated delivery')]").text
    expect(exp_delivery).to eql(pdp_delivery)
  end
end
And(/^open cart\.$/) do
  on(ProductPage).slideout_shopping_cart
end
And(/^cart contains "CNY delay delivery" message\.$/) do |msg|
  on(ProductPage) do |page|
    page.hYourBag_element.when_present
    cart_msg_delivery = page.paragraph_element(xpath:"//p[contains(text(),'high order volume')]").text
    puts cart_msg_delivery
    expect(cart_msg_delivery).to eql(msg)
    page.slidein_shopping_cart
  end
end
And(/^add a dress to cart\.$/) do
  on(ProductPage).add_to_bag
end
Then(/^check CNY delivery time on checkout\.$/) do |msg|
  on(CheckOutPage) do |page|
    page.divAddressForm_element.when_present
    estim_delivery = @browser.dd(xpath:"//div[contains(@class,'product-form')]//dd[text()='Estimated delivery: 3 - 4 weeks']").text
    expect(estim_delivery).to eql('Estimated Delivery: 3 - 4 Weeks')

    chk_msg_delivery = page.paragraph_element(xpath:"//div[contains(@class,'product-form')]//p[contains(text(),'delivery timeline')]").text
    puts chk_msg_delivery
    expect(chk_msg_delivery).to eql(msg)
  end
end

But(/^complete order\.$/) do |table|
  on(CheckOutPage) do |page|
    if session_data[browser_name][:is_authorized] == false
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      fake_email = Faker::Internet.email
      page.specify_first_name(fname: first_name)
      page.specify_last_name(lname: last_name)
      page.specify_email(email: fake_email)
    end
    page.specify_phone_num(phone_num: '2255-4422')
    page.select_country(country: 'United States')
    page.specify_street_address(street: 'Lorem street 8')
    page.specify_street_address_contd(street_cnd: 'apt. 8')
    page.specify_city(city: 'Seattle')
    page.zipcode(zipcode: '61000')
    page.select_state(state: 'Washington')
    page.select_ship_address(true)
    page.pay_securely
    data = table.rows_hash
    page.close_fee_popup
    page.fill_in_credit(data)
    @order_number = page.div_element(xpath: "//div[contains(@class,'hidden')]//div[contains(text(),'Number')]").text.scan(/[A-Z]\d{,9}$/).first
    puts "Your order number is: #{@order_number}"
    page.place_my_order
  end
end

And(/^check estimated delivery on order confirm page\.$/) do
  on(OrderPage) do |page|
    deliver_date = (Date.today + 28).strftime('%d of %b, %Y')
    page.h1_element(xpath: "//h1[text()='Thanks for your order!']").when_present(30)
    expect(page.h4_element(xpath: "//h4[text()='Expect Standard delivery: #{deliver_date}']").visible?).to be_truthy
  end
end

Then(/^check Expected delivery date in profile\.$/) do
  on(MyProfilePage) do |page|
    page.visit_site_version(country: 'USA', url: '/user_orders')
    page.tblOrdersTable_element.when_present
    d = (Date.today + 28).strftime('%m/%d/%y')
    prof_exp_delivery_date = page.cell_element(xpath:"//a[text()='#{@order_number}']/../..//td[text()='#{d}']").text
    puts prof_exp_delivery_date
  end
end

And(/^check Expected delivery date in email\.$/) do
  on(CustomerIO) do |page|
    page.goto_cio_url('')
    page.specify_cio_login(CONFIG['customer_io_login'])
    page.specify_cio_pwd(CONFIG['customer_io_pwd'])
    page.click_cio_signin
    page.goto_cio_url('/env/24584/deliveries')
    page.open_email('Order Confirmation',@order_number)
    sleep 5
    expect(@browser.iframe(xpath:"//iframe[contains(@class,'ember')]").p(xpath: "//p[text()='How long will your order take to arrive:']").visible?).to be_truthy
    expect(@browser.iframe(xpath:"//iframe[contains(@class,'ember')]").p(xpath: "//p[text()='Estimated Delivery: 3 - 4 weeks']").visible?).to be_truthy
    expect(@browser.iframe(xpath:"//iframe[contains(@class,'ember')]").p(xpath: "//p[text()='Estimated Delivery: 3 - 4 weeks']").visible?).to be_truthy
    order_volume = @browser.iframe(xpath:"//iframe[contains(@class,'ember')]").p(xpath: "//p[contains(text(),'high order volume')]").text
    expect(order_volume).to eql("We're experiencing a high order volume right now, so it's taking longer than usual to handcraft each made-to-order garment.\nWe'll be back to our normal timeline of 7-10 days soon.")
  end
end