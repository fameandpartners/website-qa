When(/^I create a new Sale\.$/) do
  on(SalesPage) do |page|
    page.visit_site_version(country: 'USA', url: '/admin/sales')
    page.click_new_sale
    sale_name = Faker::Lorem.words(2, true)
    @sale_name = sale_name.join(" ").capitalize
    puts "Generated sale name is: #{@sale_name}"
    page.specify_sale_name(@sale_name)
    sitewide_msg = Faker::Lorem.sentence(1)
    page.specify_sitewide_message("{discount} #{sitewide_msg}")
  end
end

Then(/^make it ([^"]*) discount type, active and sitewide\.$/) do |discount_type|
  on(SalesPage) do |page|
    page.activate_sale(true)
    page.make_sitewide(true)
    case discount_type
      when 'Percentage'
        @percent = Random.new.rand(10..35)
        puts "Specified percent sale is: #{@percent}%"
      when 'Fixed'
        @percent = Random.new.rand(11.2...76.9).round(2)
        puts "Specified fixed sale is: #{@percent}%"
    end
    page.specify_discount_size(@percent)

    page.select_discount_type(dicount_type)
    page.select_currency('ALL')
    page.click_create_sale
    page.visit_site_version(country: 'USA', url: '/logout')
  end
end

And(/^verify that percentage sale price is applied to products for (.*) website\.$/) do |country|
  @country = country
  on(ProductsPage) do |page|
    page.visit_site_version(country: country, url: '/dresses', basic_auth: true)
    old_price = page.span_element(xpath: "(//span[@class='price-original'])[1]").text.gsub(/[^\d\.]/, '').to_f
    sale_price = page.span_element(xpath: "(//span[@class='price-sale'])[1]").text.gsub(/[^\d\.]/, '').to_f
    discount = old_price * (1 - @percent.to_f/100).round(2)
    puts <<-EOS
  Sale is: #{@percent}%
  Old price is: #{old_price}$
  Sale price is: #{sale_price}$
  Discount price is: #{discount}$
    EOS
    expect(sale_price).to eql(discount)
  end
end

And(/^verify that fixed sale price is applied to products for (.*) website\.$/) do |country|
  @country = country
  on(ProductsPage) do |page|
    page.visit_site_version(country: country, url: '/dresses', basic_auth: true)
    old_price = page.span_element(xpath: "(//span[@class='price-original'])[1]").text.gsub(/[^\d\.]/, '').to_f
    sale_price = page.span_element(xpath: "(//span[@class='price-sale'])[1]").text.gsub(/[^\d\.]/, '').to_f
    discount = old_price - @percent.to_f
    puts <<-EOS
  Sale is: #{@percent}%
  Old price is: #{old_price}$
  Sale price is: #{sale_price}$
  Discount price is: #{discount}$
    EOS
    expect(sale_price).to eql(discount)
  end
end


Then(/^add products into your cart and go to Checkout\.$/) do
  on(ProductsPage).link_element(xpath: "(//a[contains(@class,'product-name')])[1]").when_present(30).click
  on(ProductPage) do |page|
    page.open_dress_size
    dress_size = page.get_random_dress_size(@country)
    puts "Selected dress size is: #{dress_size}"
    page.select_dress_size(dress_size)
    page.open_skirt_length
    skirt_length = page.get_random_skirt_length
    puts "Selected skirt length is: #{skirt_length.capitalize}"
    page.select_skirt_length(skirt_length)
    page.add_to_bag
  end
end

But(/^apply an additional discount using a code\.$/) do
  on(CheckOutPage) do |page|
    page.specify_coupon(CONFIG['coupon'])
    page.apply_coupon
  end
end

Then(/^get out of Checkout and continue shopping$/) do
  on(CheckOutPage) do |page|
    page.continue_shopping
  end
end

And(/^go to any of the category pages\.$/) do
  on(ProductsPage) do |page|
    page.visit_site_version(country: @country, url: '/dresses/red')
  end
end

And(/^user won't get 500th error\.$/) do
  on(ProductsPage) do |page|
    response_code = page.visit_site_version(country: @country, url: '/dresses/red', response_code: true)
    expect(page.divFilterPanel_element.visible?).to be_truthy
    puts "I'm expecting for 200 response code."
    expect(response_code.to_i).to eql(200)
    puts "Response code is really: #{response_code}"
  end
end


But(/^delete created sale\.$/) do
  on(LoginPage) do |page|
    page.visit_site_version(country: 'USA', url: '/login', basic_auth: true)
    page.specify_credentials(CONFIG['spree_admin'],CONFIG['admin_pwd'])
    page.submit_login
  end
  on(SalesPage) do |page|
    page.visit_site_version(country: 'USA', url: '/admin/sales')
    page.delete_sale(@sale_name, true)
    puts "'#{@sale_name}' sale is deleted"
  end
end

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Sale site wide discount. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When(/^I create a new (.*) Sale\.$/) do |country|
  on(SalesPage) do |page|
    page.visit_site_version(country: country, url: '/admin/sales')
    page.click_new_sale
    sale_name = Faker::Lorem.words(2, true)
    @sale_name = sale_name.join(" ").capitalize
    puts "Generated sale name is: #{@sale_name}"
    page.specify_sale_name(@sale_name)
    sitewide_msg = Faker::Lorem.sentence(1)
    page.specify_sitewide_message("{discount} #{sitewide_msg}")
  end
end

Then(/^make it active, sitewide, (.*) discount type and (.*) currency\.$/) do |discount_type, currency|
  on(SalesPage) do |page|
    page.activate_sale(true)
    page.make_sitewide(true)
    case discount_type
      when 'Percentage'
        @percent = Random.new.rand(10..35)
        puts "Specified percent sale is: #{@percent}%"
      when 'Fixed'
        @percent = Random.new.rand(11.2...76.9).round(2)
        puts "Specified fixed sale is: #{@percent}%"
    end
    page.specify_discount_size(@percent)
    page.select_discount_type(discount_type)
    page.select_currency(currency)
    page.click_create_sale
    page.visit_site_version(country: 'USA', url: '/logout')
    sleep 3
  end
end

And(/^Regular and Sale prices are displayed on category pages\.$/) do
  pending
end

And(/^Regular and Sale prices are displayed on PDP\.$/) do
  pending
end

And(/^Sale price is displayed on cart and checkout\.$/) do
  pending
end

And(/^Sale price is charged to payment method\.$/) do
  pending
end

And(/^Sale price is displayed on order confirmation email\.$/) do
  pending
end