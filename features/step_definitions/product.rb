When(/^I select "([^"]*)" site version\.$/) do |country|
  on(ProductPage) do |page|
    page.click_locale_menu
    page.select_locale(country)
    @country_version=country
  end
end


When(/^I go to "([^"]*)" site version\.$/) do |country|
  session_data[browser_name][:is_authorized] = false
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

Given(/^left bar blocks:$/) do |table|
  @left_bar_titles = table.raw
end

Given(/^right bar elements:$/) do |table|
  @right_bar_titles = table.raw
end

When(/^left side bar contains titles\.$/) do
  data = @left_bar_titles
  data.each do |rowdata|
    rowdata.each do |panel_item|
      expect(on(ProductPage).link_element(text: panel_item).present?).to be_truthy
    end
  end
end

Then(/^they can be expanded and collapsed\.$/) do
  data = @left_bar_titles
  puts data.inspect
end


And(/^right side bar contains customization elements with "Add to bag" button\.$/) do
  sleep 1
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