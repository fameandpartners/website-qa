
Given(/^I am on USA 'Kirilly' dress\.$/) do
  on(ProductPage).goto(base_name: :prod_us, url: '/dresses/dress-kirrily-1100')
end

When(/^I select "([^"]*)" site version\.$/) do |country|
  on(ProductPage) do |page|


    page.click_locale_menu
    page.select_locale(country)
    # @browser.alert.close
  end
end

Then(/^I specify properties of dress:$/) do |table|
  on(ProductPage) do |page|
    data = table.rows_hash
    page.open_dress_size
    page.select_dress_size(size: data['Dress Size'])
    page.open_skirt_length
    page.select_skirt_length(length: data['Skirt Length'].downcase)
    sleep 3
  end
end

Then(/^I add the dress to cart\.$/) do
  on(ProductPage) do |page|
    page.add_to_bag
  end
end

