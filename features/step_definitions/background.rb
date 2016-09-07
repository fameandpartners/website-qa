Given(/^Visit both site versions for 'Kirilly' dress page\.$/) do
  on(ProductPage) do |page|
    page.goto(base_name: :prod_us, url: '/dresses/dress-kirrily-1100')
    page.goto(base_name: :prod_au, url: '/dresses/dress-kirrily-1100')
  end
end

Given(/^I am on 'Contact Us' page\.$/) do
  visit ContactUsPage
end