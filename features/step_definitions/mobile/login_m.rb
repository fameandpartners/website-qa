Given(/^open mobile login page\.$/) do
  on LoginPage do |page|
    page.visit_site_version(country: 'USA', url: '/dresses/dress-kirrily-1100')
  end
end

When(/^I specify credentials\.$/) do

  sleep 2

end