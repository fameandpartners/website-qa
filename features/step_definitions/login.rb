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
    page.specify_registered_user(browser_name)
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
    page.specify_registered_user(browser_name)
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
Then(/^I specify fake email\.$/) do
  on(LoginPage) do |page|
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
Then(/^I specify registered email\.$/) do
  on(LoginPage).specify_registered_user(browser_name)
end

But(/^password is incorrect\.$/) do
  on(LoginPage).specify_pwd('abracadabra')
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ User can NOT login with correct password and empty login. ~~~~~~~~~~~~~~~~~~
Then(/^I do not specify email\.$/) do
  on(LoginPage).specify_email('')
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ User can NOT login with correct password and empty login. ~~~~~~~~~~~~~~~~~~
When(/^I do not specify nor email nor password\.$/) do
  on(LoginPage) do |page|
    page.specify_email('')
    page.specify_pwd('')
    page.submit_login
  end
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
And(/^I can login from "Forgot Password" form\.$/) do
  on(ForgotPwdPage).sign_in_link
  on(LoginPage) do |page|
    if browser_name == 'chrome'
      page.specify_credentials(CONFIG['chrome_user'],CONFIG['chrome_user_pwd'])
    elsif browser_name == 'firefox'
      page.specify_credentials(CONFIG['firefox_user'],CONFIG['firefox_user_pwd'])
    elsif browser_name == 'internet explorer'
      page.specify_credentials(CONFIG['ie_user'],CONFIG['ie_user_pwd'])
    elsif browser_name == 'safari'
      sleep 2
      page.specify_credentials(CONFIG['safari_user'],CONFIG['safari_user_pwd'])
    end
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