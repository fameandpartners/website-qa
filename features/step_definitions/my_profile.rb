Given(/^I am on Home page as logged in user\.$/) do
  visit HomePage
  on(HomePage).click_my_account
  on(LoginPage) do |page|
    page.specify_credentials(CONFIG['user_email'],CONFIG['user_pwd'])
    page.submit_login
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ . ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When(/^I open 'My Details' page\.$/) do
  on(HomePage) do |page|
    page.hover_my_account
    page.open_account_submenu('details')
  end
end


Then(/^I can modify First and Last names with:$/) do |table|
  on(MyProfilePage) do |page|
    data = table.rows_hash
    page.update_profile(data)
  end
sleep 3

end