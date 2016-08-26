
Given(/^I am on 'Kirilly' dress\.$/) do
  visit ProductPage
end

When(/^I specify properties of dress:$/) do |table|
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
