Given(/^as a customer I buy a dress\.$/) do |table|
  on(LoginPage) do |page|
    page.visit_site_version(country: 'USA', url: '', basic_auth: true)
    page.visit_site_version(country: 'USA', url: '/dresses/dress-kirrily-1100')
  end
  on(ProductPage) do |page|
    page.open_dress_size
    @dress_size = MainBasePage::USA_SIZES[rand(MainBasePage::USA_SIZES.length)]
    page.select_dress_size(@dress_size)
    puts "Selected dress size is: #{@dress_size}"
    page.open_skirt_length
    @dress_length = MainBasePage::LENGTH[rand(MainBasePage::LENGTH.length)]
    page.select_skirt_length(@dress_length)
    puts "Selected dress length is: #{@dress_length}"
    @dress_color = page.div_element(xpath: "//div[text()='Color']/..//div[contains(@class,'content__right')]").text
    puts "Selected dress color is: #{@dress_color}"
    @product_price = page.divProductPrice_element.text.gsub(/[^\d\.]/, '').to_f
    puts "Product price is: #{@product_price}"
    page.add_to_bag
  end
  on(CheckOutPage) do |page|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    @email = Faker::Internet.safe_email(first_name+'_'+last_name)
    page.specify_first_name(fname: first_name)
    page.specify_last_name(lname: last_name)
    page.specify_email(email: @email)
    cell_phone = Faker::PhoneNumber.cell_phone
    page.specify_phone_num(phone_num: cell_phone)
    page.select_country(country: 'United States')
    street_address = Faker::Address.street_address
    page.specify_street_address(street: street_address)
    secondary_address = Faker::Address.secondary_address
    page.specify_street_address_contd(street_cnd: secondary_address)
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
    page.place_my_order
    page.h3_element(xpath: "//h3[text()='Order # #{@order_number}']").when_present(30)
    page.visit_site_version(country: 'USA', url: '/profile')
  end
  on(MyProfilePage) do |page|
    page.my_account_pwd('1qazxcv')
    page.my_account_confirm_pwd('1qazxcv')
    page.save_profile_changes
  end
end

Then(/^I open created order\.$/) do
  on(LogoutPage).visit_site_version(country: 'USA', url: '/logout')
  on(LoginPage) do |page|
    page.visit_site_version(country: 'USA', url: '/login')
    page.specify_credentials(CONFIG['spree_admin'],CONFIG['admin_pwd'])
    page.submit_login
  end
  on(OrdersPage) do |page|
    page.visit_site_version(country: 'USA', url: "/admin/orders/#{@order_number}")
    page.h1_element(xpath: "//h1[contains(text(),'#{@order_number}')]").when_present
  end
end

Then(/^user can request for "Return or exchange"\.$/) do
  on(LoginPage) do |page|
    page.visit_site_version(country: 'USA', url: '/logout')
    page.visit_site_version(country: 'USA', url: '/login')
    page.specify_email(@email)
    page.specify_pwd('1qazxcv')
    page.submit_login
  end
  on(MainBasePage).visit_site_version(country: 'USA', url: '/user_orders')
  on(MyProfilePage) do |page|
    page.tblOrdersTable_element.when_present(30)
    page.link_element(xpath: "//a[text()='#{@order_number}']/../..//a[text()='Return or exchange']").when_present(30).click
  end
end


And(/^all data of selected dress are correct\.$/) do

end


