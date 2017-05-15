Given(/^open mobile login page\.$/) do
  on MobileLoginPage do |page|
    page.visit_site_version(country: 'USA', url: '/login', basic_auth: true)
  end
end

When(/^I specify credentials\.$/) do

  sleep 2

end