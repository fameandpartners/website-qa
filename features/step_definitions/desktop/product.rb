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
  on(ProductPage).visit_site_version(country: country, url: '/dresses/dress-kirrily-1100?color=spot')
  @country_version=country
end


Then(/^specify "([^"]*)" dress Size and "([^"]*)" skirt length of the dress\.$/) do |dress_size, skirt_length|
  on(ProductPage) do |page|
    page.open_dress_size
    page.select_dress_size(dress_size)
    page.open_skirt_length
    page.select_skirt_length(skirt_length.downcase)
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
    expect(share_icons.inject([]){|arr, n| arr << page.send("#{n}_element") }).to all(be_visible)
    page.lstShareIcons_element.wait_until_present
    page.collapse_share
    page.lstShareIcons_element.wait_while_present
  end
end


And(/^right bar contains customization elements\:$/) do |table|
  data = table.raw
  data.each do |rowdata|
    rowdata.each do |panel_item|
      expect(on(ProductPage).div_element(text: panel_item).present?).to be_truthy
    end
  end
end

When(/^I select "Dress Size" and "Height & Hemline":$/) do |table|
  on(ProductPage) do |page|
    data = table.rows_hash
    page.open_dress_size
    page.specify_your_size(dress_size: data['Dress Size'])
    page.open_skirt_length
    page.specify_your_height_hemline(height_hemline: data['Height & Hemline'].downcase)
  end
end

Then(/^I can add a dress to bag\.$/) do
  on(ProductPage) do |page|
    page.add_to_bag
    page.divDressSize_element.wait_while_present
  end
end


Then(/^they can be opened and closed\.$/) do
  on(ProductPage) do |page|
    page.open_dress_size
    page.close_dress_size
    page.open_skirt_length
    page.close_skirt_length
    page.open_color
    page.close_color
    page.open_customize
    page.close_customize
  end
end

But(/^"Add to bag" button becomes enabled when "Dress Size" and "Height & Hemline" are selected\.$/) do
  on(ProductPage) do |page|
    page.open_dress_size
    page.select_dress_size('US 10')
    page.open_skirt_length
    page.select_skirt_length('STANDARD'.downcase)
    expect(page.lnkAddToBag_element.attribute_value('disabled')).to be_falsy
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
    page.visit_site_version(country: 'USA', url: '/dresses/dress-kirrily-1100?color=spot')
    page.click_amber_image
  end
end