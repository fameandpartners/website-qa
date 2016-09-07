Then(/^I go to Forgot Password form\.$/) do
  on(LoginPage).open_forgot_pwd
end
#~~~ Reset a password. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
And(/^I want to reset my password\.$/) do
  on(ForgotPwdPage) do |page|
    page.specify_email(CONFIG['user_email'])
    page.click_reset
  end
end
Then(/^message about receiving email with instructions appears\.$/) do
  on(LoginPage) do |page|
    page.btnLogin_element.when_present
    expect(page.spnResetPwdNtf_element.visible?).to be_truthy
  end
  # expect(LoginPage.spnResetPwdNtf_element.visible?).to be_truthy
end
And(/^I am able to reset my password\.$/) do
  visit Gmail
  on(Gmail) do |page|
    page.specify_gmail(CONFIG['user_email'])
    page.go_next
    page.specify_gpwd(CONFIG['gmail_pwd'])
    page.sign_in_gmail
    page.open_res_email
    page.click_reset_link
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


And(/^there are all Reset Password page controls\.$/) do
  pending
end