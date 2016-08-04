Given(/^I am on home page$/) do
  visit HomePage
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Login with email. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When(/^I open Login form\.$/) do
  on(HomePage).click_my_account
end

Then(/^I want to login with email as user\.$/) do
  on(LoginPage) do |page|
    page.specify_credentials(CONFIG['user_name'],CONFIG['user_pwd'])
    page.submit_login
  end
end

And(/^be sure I was logged in\.$/) do
  on HomePage do |page|
    page.click_my_account
    expect(page.current_url).to include('/profile')
  end

end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Sign Up with email. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Then(/^I want to sign up with email.$/) do
  on(LoginPage) do |page|
    page
  end
end

And(/^be sure I was signed up\.$/) do
  sleep 1
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Sign Up with Facebook account. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


