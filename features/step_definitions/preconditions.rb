When(/^I am on Fame admin feature flags\.$/) do
  on(LoginPage).visit_site_version(country: 'USA', url: '/fame_admin/backend/features')
end


When(/^I go to Sales tab\.$/) do
  on(SalesPage).visit_site_version(country: 'USA', url: '/admin/sales')
end

Then(/^deactivate active Sale\(s\)\.$/) do
  on(SalesPage) do |page|
    page
  end
end