Given(/^I am on home page.$/) do
  visit HomePage
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Check all Login form elements. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Then(/^there are all required controls\.$/) do
  on(LoginPage) do |page|
    login_ctrls=%w(hLogin lnkFaceBook spnOr lblEmail txtEmail lblPwd txtPwd chkRemMe spnRemMe btnLogin lnkCreateAcc lnkForgotPwd)
    expect(login_ctrls.inject([]){|arr, n| arr << page.send("#{n}_element") }).to all(be_visible)
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Login with email. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When(/^I open Login form\.$/) do
  on(HomePage).click_my_account
end
Then(/^I want to login with email as user\.$/) do
  on(LoginPage) do |page|
    page.specify_credentials(CONFIG['user_email'],CONFIG['user_pwd'])
    page.submit_login
  end
end
And(/^be sure I was logged in\.$/) do
  on(HomePage) do |page|
    page.click_my_account
    expect(page.current_url).to include('/pofile')
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Login with Remember Me option. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Then(/^I want to login with email and Remember Me option\.$/) do
  on(LoginPage) do |page|
    page.specify_credentials(CONFIG['user_email'],CONFIG['user_pwd'])
    page.remember_me(true)
    page.submit_login
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Sign Up with email. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Then(/^I want to create a new account\.$/) do
  on(LoginPage) do |page|
    page.create_account
  end
end
And(/^be sure a new account was created\.$/) do
  pending
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Login with Facebook account. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Then(/^I want to login with Facebook account\.$/) do
  pending
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ User can NOT login with incorrect email credentials. ~~~~~~~~~~~~~~~~~~~~~~~
When(/^I specify incorrect credentials\.$/) do
  pending
end
Then(/^I will see "([^"]*)" error message\.$/) do |msg|
  pending
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Reset a password. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
And(/^I want to reset my password\.$/) do
  pending
end
Then(/^message about receiving email with instructions appears\.$/) do
  pending
end
And(/^I am able to reset my password\.$/) do
  pending
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Login from Forgot Password form. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Then(/^I go to Forgot Password form\.$/) do
  on(LoginPage) do |page|
    page.open_forgot_pwd
  end
end
And(/^I can login from Forgot Password form\.$/) do
  on(ForgotPwdPage).sign_in
  on(LoginPage) do |page|
    page.specify_credentials(CONFIG['user_email'],CONFIG['user_pwd'])
    page.remember_me(false)
    page.submit_login
  end
  on(HomePage) do |page|
    page.click_my_account
    expect(page.current_url).to include('/profile')
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Create a new account from Forgot Password form. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
And(/^create a new account from Forgot Password form\.$/) do
  pending
end