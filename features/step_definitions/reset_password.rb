Then(/^I go to "Forgot Password" form\.$/) do
  on(HomePage).click_my_account
  on(LoginPage).open_forgot_pwd
end
#~~~ Reset a password. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
And(/^I want to reset my password\.$/) do
  on(LoginPage).open_forgot_pwd
  on(ForgotPwdPage) do |page|
    if browser_name == 'chrome'
      page.specify_email(CONFIG['chrome_user'])
    elsif browser_name == 'firefox'
      page.specify_email(CONFIG['firefox_user'])
    elsif browser_name == 'internet explorer'
      page.specify_email(CONFIG['ie_user'])
    elsif browser_name == 'safari'
      sleep 2
      page.specify_email(CONFIG['safari_user'])
    end
    page.click_reset
  end
end

Then(/^message about receiving email with instructions appears\.$/) do
  on(LoginPage) do |page|
    page.btnLogin_element.when_present
    expect(page.spnResetPwdNtf_element.visible?).to be_truthy
  end
end
And(/^I am able to reset my password\.$/) do
  visit Gmail
  on(Gmail) do |page|
    if browser_name == 'chrome'
      page.specify_gmail(CONFIG['chrome_user'])
      page.go_next
      page.specify_gpwd(CONFIG['chrome_user_pwd'])
    elsif browser_name == 'firefox'
      page.specify_gmail(CONFIG['firefox_user'])
      page.go_next
      page.specify_gpwd(CONFIG['firefox_user_pwd'])
    elsif browser_name == 'internet explorer'
      page.specify_gmail(CONFIG['ie_user'])
      page.go_next
      page.specify_gpwd(CONFIG['ie_user_pwd'])
    elsif browser_name == 'safari'
      page.specify_gmail(CONFIG['safari_user'])
      page.go_next
      page.specify_gpwd(CONFIG['safari_user_pwd'])
    end
    page.sign_in_gmail
    page.goto_inbox
    page.open_res_email
    page.click_reset_link
  end
  @browser.windows.last.use
  on(ForgotPwdPage) do |page|
    if browser_name == 'chrome'
      page.specify_new_pwd(CONFIG['chrome_user_pwd'])
      page.specify_new_pwd_confirm(CONFIG['chrome_user_pwd'])
    elsif browser_name == 'firefox'
      page.specify_new_pwd(CONFIG['firefox_user_pwd'])
      page.specify_new_pwd_confirm(CONFIG['firefox_user_pwd'])
    elsif browser_name == 'internet explorer'
      page.specify_new_pwd(CONFIG['ie_user_pwd'])
      page.specify_new_pwd_confirm(CONFIG['ie_user_pwd'])
    elsif browser_name == 'safari'
      page.specify_new_pwd(CONFIG['safari_user_pwd'])
      page.specify_new_pwd_confirm(CONFIG['safari_user_pwd'])
    end
    page.click_change_pwd
  end
  visit MyProfilePage
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


And(/^there are all Reset Password page controls\.$/) do
  pending
end