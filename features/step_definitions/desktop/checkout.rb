#~~~ Successfully buy a dress as registered user.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# require 'pry-remote'
Then(/^I fill in form fields with:$/) do |table|
  on(CheckOutPage) do |page|
    data = table.rows_hash
    if session_data[browser_name][:is_authorized] == false
      page.specify_first_name(fname: data['First Name'])
      page.specify_last_name(lname: data['Last Name'])
      page.specify_email(email: data['Email'])
    elsif browser_name == 'internet explorer'
      page.specify_first_name(fname: 'Internet')
      page.specify_last_name(lname: 'Explorer')
      page.specify_email(email: CONFIG['ie_user'])
    end
    page.specify_phone_num(phone_num: data['Phone Number'])
    page.select_country(country: data['Country'])
    page.specify_street_address(street: data['Street Address'])
    page.specify_street_address_contd(street_cnd: data['Street Address (contd)'])
    page.specify_city(city: data['City'])
    page.zipcode(zipcode: data['Zipcode'])
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
    @order_number = page.div_element(xpath: "//div[contains(@class,'hidden')]//div[contains(text(),'Number')]").text.scan(/[A-Z]\d{,9}$/).first
    puts "Your order number is: #{@order_number}"
    page.pay_securely
  end
end

And(/^click on 'Place My Order' button\.$/) do
  on(CheckOutPage) do |page|
    page.place_my_order
  end
end

Then(/^"([^"]*)" page with order number displayed\.$/) do |message|
  on(OrderPage) do |page|
    page.h1_element(xpath: "//h1[text()='#{message}']").when_present(30)
    @complete_order_number = page.h3_element(xpath: "//h3[@class='order-number']").text.scan(/[A-Z]\d{,9}$/).first
    expect(@order_number).to eql(@complete_order_number)
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Successfully buy a dress as registered user.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
And(/^set "This is also my billing address"\.$/) do
  on(CheckOutPage) do |page|
    page.select_ship_address(true)
  end
end

And(/^confirm custom duty fees\.$/) do
  on(CheckOutPage).confirm_custom_duty_fees(true)
end

But(/^check "Order summary"\.$/) do
  on(CheckOutPage) do |page|
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
  end
end

But(/^check "Order summary" with a discount coupon\.$/) do
  on(CheckOutPage) do |page|
    sub_total = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//p[contains(text(),'Sub Total')]//span").text.gsub(/[^\d\.]/, '').to_f
    shipping = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//p[contains(text(),'Shipping')]//span").text.gsub(/[^\d\.]/, '').to_f
    promotion = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//p[contains(text(),'Promotion')]//span").text.gsub(/[^\d\.]/, '').to_f
    order_total = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//p[contains(text(),'Order Total')]//span").text.gsub(/[^\d\.]/, '').to_f
    puts <<-EOS
      Sub Total: #{sub_total}
      Shipping: #{shipping}
      Promotion: -#{promotion}
      Order Total: #{order_total}

    EOS
    @prices = {
        sub_total:  sub_total,
        shipping: shipping,
        order_total: order_total,
        promotion: promotion
    }
    order_total_coupon = (@prices[:sub_total]-@prices[:promotion])+@prices[:shipping]
    puts "Order total with coupon: #{order_total_coupon}"
    expect(@prices[:order_total]).to eql(order_total_coupon)
  end
end

But(/^check "Order summary" with custom duty fees\.$/) do
  on(CheckOutPage) do |page|
    sub_total = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//p[contains(text(),'Sub Total')]//span").text.gsub(/[^\d\.]/, '').to_f
    shipping = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//p[contains(text(),'Shipping')]//span").text.gsub(/[^\d\.]/, '').to_f
    order_total = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//p[contains(text(),'Order Total')]//span").text.gsub(/[^\d\.]/, '').to_f
    @prices = {
        sub_total:  sub_total,
        shipping: shipping,
        order_total: order_total
    }
    expect(@product_price).to eql(@prices[:sub_total])
    order_total_fee = @prices[:sub_total]+@prices[:shipping]
    puts order_total_fee
    expect(@prices[:order_total]).to eql(order_total_fee)
  end
end

Then(/^apply a coupon for 25% discount\.$/) do
  on(CheckOutPage) do |page|
    page.specify_coupon(CONFIG['coupon'])
    page.apply_coupon
  end
end

And(/^I go to checkout process\.$/) do
  on(CheckOutPage) do |page|
    expect(page.current_url).to include('/checkout')
  end
end

Then(/^I can delete the dress from cart\.$/) do
  on(CheckOutPage) do |page|
    page.span_element(xpath: "//div[contains(@class,'product-form-side')]//a[text()='Kirrily']/../..//span[@class='icon btn-close']")\
.when_present(30).click
    sleep 3
  end
end

But(/^"([^"]*)" popup appears\.$/) do |msg|
  on(CheckOutPage).h2_element(xpath: "//div[contains(@class,'product-form-side')]//h2[text()='#{msg}']").when_present(30)
end

And(/^I can continue shopping\.$/) do
  on(CheckOutPage).lnkContShopping_element.when_present(30).click
  on(HomePage) do |page|
    page.ordered_list_element(css:".breadcrumb.hidden-xs.hidden-sm").when_present(30)
    expect(page.current_url).to include('fameandpartners.com/dresses')
  end
end