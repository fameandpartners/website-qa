Given(/^I am on Home page\.$/) do
  on(HomePage) do |page|
    page.visit_site_version(country: 'Australia', url: '')
    page.visit_site_version(country: 'USA', url: '')
  end
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
    expect(page.current_url).to include('/profile')
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Login with Remember Me option. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Then(/^I want to login with Remember Me option\.$/) do
  on(LoginPage) do |page|
    page.specify_credentials(CONFIG['user_email'],CONFIG['user_pwd'])
    page.remember_me(true)
    page.submit_login
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~ Login with Facebook account. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Then(/^I want to login with Facebook account\.$/) do
  pending
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ User can NOT login with fake email. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When(/^I specify fake email\.$/) do
  on(LoginPage) do |page|
    page.click_my_account
    page.specify_email('fake@email.com')
  end
end
But(/^password is correct\.$/) do
  on(LoginPage).specify_pwd('1qazxcv')
end
And(/^I click 'Login' button\.$/) do
  on(LoginPage).submit_login
end
Then(/^I will see "([^"]*)" error message\.$/) do |msg|
  expect(on(LoginPage).text.include?(msg)).to be_truthy
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ User can NOT login with incorrect password. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When(/^I specify registered email\.$/) do
  on(LoginPage) do |page|
    page.click_my_account
    page.specify_email(CONFIG['user_email'])
  end
end

But(/^password is incorrect\.$/) do
  on(LoginPage).specify_pwd('abracadabra')
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ User can NOT login with correct password and empty login. ~~~~~~~~~~~~~~~~~~
When(/^I do not specify email\.$/) do
  on(LoginPage) do |page|
    page.click_my_account
    page.specify_email('')
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ User can NOT login with correct password and empty login. ~~~~~~~~~~~~~~~~~~
When(/^I do not specify nor email nor password\.$/) do
  pending
end




#~~~ I should specify incorrect email format. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When(/^I specify incorrect email format\.$/) do
  on(LoginPage) do |page|
    page.click_my_account
    page.specify_email('just_email')
    page.submit_login
  end
end

Then(/^I will see "([^"]*)" tooltip\.$/) do |tooltip|

  expect(on(LoginPage).txtEmail_element.title).to eql(tooltip)
  # label(:text => "Help").title.should eq("Hint Text")
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Login from Forgot Password form. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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


But(/^password is empty\.$/) do
  on(LoginPage).specify_pwd('')
end