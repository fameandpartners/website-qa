When(/^I am on Fame admin feature flags\.$/) do
  on(LoginPage).visit_site_version(country: 'USA', url: '/fame_admin/backend/features')
end

