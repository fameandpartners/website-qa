When(/^I select "([^"]*)" site version\.$/) do |country|
  on(ProductPage) do |page|
    page.click_locale_menu
    page.select_locale(country)
  end
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
