When(/^I select "([^"]*)" site version\.$/) do |country|
  on(ProductPage) do |page|
    page.click_locale_menu
    page.select_locale(country)
    @country_version=country
  end
end


When(/^I go to "([^"]*)" site version\.$/) do |country|
  session_data[browser_name][:is_authorized] = false
  on(ProductPage).visit_site_version(country: country, url: '', basic_auth: true)
  @country_version=country
end


Then(/^specify random dress size and growth for the dress\.$/) do
  on(ProductPage) do |page|
    page.visit_site_version(country: @country_version, url: '/dresses/dress-eclectic-love-dress-1114?color=rosewater-floral')

    page.open_size_profile
    page.change_metric('cm')
    random_growth = page.get_random_growth.to_i
    puts "Random growth is: #{random_growth}cm"
    page.specify_your_growth(random_growth)

    random_size = page.get_random_dress_size(@country_version)
    puts "Random size is: #{random_size}"
    page.specify_random_size(random_size)

    page.save_pdp_size_profile
  end
end

Then(/^add the dress to cart\.$/) do
  on(ProductPage) do |page|
    @product_price = page.divProductPrice_element.text.gsub(/[^\d\.]/, '').to_f
    page.add_to_bag
  end
end

Given(/^right bar elements:$/) do |table|
  @right_bar_elements = table.raw
end

When(/^left side bar contains info blocks\:$/) do |table|
  data = table.raw
  data.each do |rowdata|
    rowdata.each do |panel_item|
      expect(on(ProductPage).link_element(text: panel_item).present?).to be_truthy
    end
  end
end

Then(/^they can be expanded or collapsed\.$/) do
  on(ProductPage) do |page|
    page.expand_description
    page.divDescription_element.wait_until_present
    page.collapse_description
    page.divDescription_element.wait_while_present

    page.expand_fabric_information
    page.divFabric_element.wait_until_present
    page.collapse_fabric_information
    page.divFabric_element.wait_while_present

    page.expand_about_model
    page.divAboutModel_element.wait_until_present
    page.collapse_about_model
    page.divAboutModel_element.wait_while_present

    page.expand_share
    share_icons=%w(lnkFacebookShare lnkTwitterShare lnkPinterestShare)
    expect(share_icons.inject([]) { |arr, n| arr << page.send("#{n}_element") }).to all(be_visible)
    page.lstShareIcons_element.wait_until_present
    page.collapse_share
    page.lstShareIcons_element.wait_while_present
  end
end


And(/^right bar contains customization elements\:$/) do |table|
  data = table.raw
  # self.txtNameOnCard_element.value = data['Name on card']
  on(ProductPage) do |page|
    expect(page.div_element(text: data['Color selection']).present?).to be_truthy
    expect(page.link_element(text: 'Customize It').present?).to be_truthy
    expect(page.link_element(text: 'Size Profile').present?).to be_truthy
  end
end

When(/^I select random "Dress Size" and "Growth"\.$/) do
  on(ProductPage) do |page|
    page.open_size_profile
    page.change_metric('cm')
    random_growth = page.get_random_growth.to_i
    puts "Random growth is: #{random_growth}cm"
    page.specify_your_growth(random_growth)

    random_size = page.get_random_dress_size('USA')
    puts "Random size is: #{random_size}"
    page.specify_random_size(random_size)

    page.save_pdp_size_profile
  end
end

Then(/^select random customization\.$/) do
  on(ProductPage) do |page|
    page.open_customize_it
    page.select_random_customization
    page.apply_customizations
    # page.puts_existing_customizations
  end
end


Then(/^I can add a dress to bag\.$/) do
  on(ProductPage) do |page|
    page.add_to_bag
    page.hDesignDress_element.wait_while_present
  end
end


Then(/^they can be opened and closed\.$/) do
  on(ProductPage) do |page|
    page.open_color
    page.close_color
    page.open_customize
    page.close_customize


    page.open_size_profile
    page.close_pdp_size_profile
  end
end

But(/^"Add to bag" button redirects to Checkout when "Size Profile" is selected\.$/) do
  on(ProductPage) do |page|
    page.open_size_profile
    page.change_metric('cm')
    random_growth = page.get_random_growth.to_i
    puts "Random growth is: #{random_growth}cm"
    page.specify_your_growth(random_growth)

    random_size = page.get_random_dress_size('USA')
    puts "Random size is: #{random_size}"
    page.specify_random_size(random_size)

    page.save_pdp_size_profile
    page.add_to_bag
    page.hDesignDress_element.wait_while_present
  end
  on(CheckOutPage) do |page|
    expect(page.current_url).to include('/checkout')
  end
end


And(/^Free Styling Session is available\.$/) do
  on(FreeStylingSessionPage) do |page|
    page.frmFormStyleSession_element.when_present(30)
  end
end

Then(/^I can open Free Styling Session via "Book NOW" link\.$/) do
  on(ProductPage) do |page|
    page.click_book_now
  end
end

Then(/^I can open Free Styling Session via "Amber Bond" image link\.$/) do
  on(ProductPage) do |page|
    page.visit_site_version(country: 'USA', url: '/dresses/dress-eclectic-love-dress-1114?color=rosewater-floral')
    page.click_amber_image
  end
end

