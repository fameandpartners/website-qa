Given(/^I create a new guest user order\.$/) do |table|
  on(ProductPage) do |page|
    page.visit_site_version(country: 'USA', url: '', basic_auth: true)
    page.visit_site_version(country: 'USA', url: '/dresses/dress-kirrily-1100')
    page.open_dress_size
    page.select_dress_size('US 10')
    page.open_skirt_length
    page.select_skirt_length('PETITE'.downcase)
    page.add_to_bag
  end
  on(CheckOutPage) do |page|
    page.specify_first_name(fname: 'Lorem')
    page.specify_last_name(lname: 'Ipsum')
    page.specify_email(email: 'test@email.com')
    page.specify_phone_num(phone_num: '2255-4422')
    page.select_country(country: 'United States')
    page.specify_street_address(street: 'Lorem street 8')
    page.specify_street_address_contd(street_cnd: 'apt. 8')
    page.specify_city(city: 'Seattle')
    page.zipcode(zipcode: '12345')
    page.select_state(state: 'Washington')
    page.select_ship_address(true)
    @order_number = page.div_element(xpath: "//div[contains(@class,'hidden')]//div[contains(text(),'Number')]").text.scan(/[A-Z]\d{,9}$/).first
    puts @order_number
    page.pay_securely
    data = table.rows_hash
    page.close_fee_popup
    page.fill_in_credit(data)
    sub_total = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//p[contains(text(),'Sub Total')]//span").text.gsub(/[^\d\.]/, '').to_f
    shipping = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//p[contains(text(),'Shipping')]//span").text.gsub(/[^\d\.]/, '').to_f
    order_total = page.span_element(xpath: "//div[contains(@class,'product-form-side')]//p[contains(text(),'Order Total')]//span").text.gsub(/[^\d\.]/, '').to_f
    @prices = {
        sub_total:  sub_total,
        shipping: shipping,
        order_total: order_total
    }
    page.place_my_order
    page.h3_element(xpath: "//h3[text()='Order # #{@order_number}']").when_present(30)
  end
end

Then(/^I go to created guest user order\.$/) do
  on(LogoutPage).visit_site_version(country: 'USA', url: '/logout')
  on(LoginPage) do |page|
    page.visit_site_version(country: 'USA', url: '/login')
    page.specify_credentials(CONFIG['spree_admin'],CONFIG['admin_pwd'])
    page.submit_login
  end

  on(FameAdminPage) do |page|
    page.visit_site_version(country: 'USA', url: "/admin/orders/#{@order_number}")
    on(LoginPage) do |page|
      if page.btnLogin_element.visible?
        page.specify_credentials(CONFIG['spree_admin'],CONFIG['admin_pwd'])
        page.submit_login
      end
    end
    page.h1_element(xpath: "//h1[contains(text(),'#{@order_number}')]").when_present
  end
end

And(/^I can change "Make status" to:$/) do |table|
  on (OrdersPage) do |page|
    data = table.raw
    data.each do |rowdata|
      rowdata.each do |make_status|
        page.change_make_status(make_status)
        # page.refresh
        page.sltMakeStatus_element.when_present
        expect(page.sltMakeStatus_element.selected_options(&:text)[0]).to eql(make_status)
        puts "\"#{make_status}\" make status was selected."
      end
    end
  end
end

And(/^it appears in "([^"]*)" orders admin area\.$/) do |country|
  on(LogoutPage).visit_site_version(country: country, url: '/logout')
  on(LoginPage) do |page|
    page.visit_site_version(country: country, url: '/login')
    page.specify_credentials(CONFIG['spree_admin'],CONFIG['admin_pwd'])
    page.submit_login
  end
  on(OrdersPage) do |page|
    page.visit_site_version(country: country, url: "/admin/orders/#{@complete_order_number}")
    on(LoginPage) do |page|
      if page.btnLogin_element.visible?
        page.specify_credentials(CONFIG['spree_admin'],CONFIG['admin_pwd'])
        page.submit_login
      end
    end
    page.h1_element(xpath: "//h1[contains(text(),'#{@complete_order_number}')]").when_present(30)
    admin_sub_total = page.span_element(xpath: "//tr[@id='subtotal-row']//td[@class='total']//span").text.gsub(/[^\d\.]/, '').to_f
    admin_shipping = page.span_element(xpath: "//*[@id='order-charges']//td[@class='total']/span").text.gsub(/[^\d\.]/, '').to_f
    admin_order_total = page.span_element(xpath: "//td[@id='order-total']/span").text.gsub(/[^\d\.]/, '').to_f
    expect(@prices[:sub_total]).to eql(admin_sub_total)
    expect(@prices[:shipping]).to eql(admin_shipping)
    expect(@prices[:order_total]).to eql(admin_order_total)
  end
end

Then(/^I go to created order\.$/) do
  on(LogoutPage).visit_site_version(country: 'USA', url: '/logout')
  on(LoginPage) do |page|
    page.visit_site_version(country: 'USA', url: '/login')
    page.specify_credentials(CONFIG['spree_admin'],CONFIG['admin_pwd'])
    page.submit_login
  end
  on(OrdersPage) do |page|
    page.visit_site_version(country: 'USA', url: "/admin/orders/#{@order_number}")
    page.h1_element(xpath: "//h1[contains(text(),'#{@order_number}')]").when_present
    admin_sub_total = page.span_element(xpath: "//tr[@id='subtotal-row']//td[@class='total']//span").text.gsub(/[^\d\.]/, '').to_f
    admin_shipping = page.span_element(xpath: "//*[@id='order-charges']//td[@class='total']/span").text.gsub(/[^\d\.]/, '').to_f
    admin_order_total = page.span_element(xpath: "//td[@id='order-total']/span").text.gsub(/[^\d\.]/, '').to_f
    expect(@prices[:sub_total]).to eql(admin_sub_total)
    expect(@prices[:shipping]).to eql(admin_shipping)
    expect(@prices[:order_total]).to eql(admin_order_total)
  end
end



Then(/^I can add an adjustment for it\.$/) do
  on(OrdersPage) do |page|
    page.open_adjustments
    page.new_adjustment
    adjustment_amount = 25
    page.specify_adjustment_amount(adjustment_amount)
    adjustment_description = 'Test adjustment description'
    page.specify_adjustment_description(adjustment_description)
    page.continue_adjustment
    page.tblAdjustments_element.when_present
    expect(page.cell_element(xpath: "//td[text()='#{adjustment_description}']/../td[text()='$#{adjustment_amount}.00']").visible?).to be_truthy
  end
end

And(/^be sure that it recalculated correctly\.$/) do
  on(OrdersPage) do |page|
    page.open_order_details
    page.tblOrderDetails_element.when_present
    admin_order_total = page.span_element(xpath: "//span[@id='order_total']").text.gsub(/[^\d\.]/, '').to_f
    @new_order_total = @prices[:order_total] + 25
    expect(admin_order_total).to eql(@new_order_total)
  end
end

Then(/^I can remove added adjustment for it\.$/) do
  on(OrdersPage) do |page|
    page.open_adjustments
    page.delete_adjustment(true)
  end
end

And(/^be sure that it recalculated correctly after adjustment removing\.$/) do
  on(OrdersPage) do |page|
    page.open_order_details
    page.tblOrderDetails_element.when_present
    admin_order_total = page.span_element(xpath: "//span[@id='order_total']").text.gsub(/[^\d\.]/, '').to_f
    @new_order_total = @new_order_total - 25
    expect(admin_order_total).to eql(@new_order_total)
  end
end

Then(/^I change make status to "([^"]*)"\.$/) do |make_status|
  on (OrdersPage) do |page|
    page.change_make_status(make_status)
  end
end


And(/^"Return or exchange" is available for user\.$/) do
  on(MainBasePage).visit_site_version(country: 'USA', url: '/logout')
  on(MainBasePage).visit_site_version(country: 'USA', url: '/login')
  on(LoginPage) do |page|
    page.specify_registered_user(browser_name)
    page.submit_login
  end
  on(MainBasePage).visit_site_version(country: 'USA', url: '/user_orders')
  on(MyOrdersPage) do |page|
    page.tblMyOrders_element.when_present(30)
    expect(page.link_element(xpath: "//a[text()='#{@order_number}']/../..//a[text()='Return or exchange']").visible?).to be_truthy
  end
end


And(/^order sidebar menu contains:$/) do |table|
  data = table.raw
  data.each do |rowdata|
    rowdata.each do |menu_item|
      expect(on(OrdersPage).span_element(xpath: "//span[text()='#{menu_item}']").present?).to be_truthy
    end
  end
end