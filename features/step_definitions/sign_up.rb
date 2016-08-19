#~~~ Open Sign Up form. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When(/^I open Sign Up form\.$/) do
  on(HomePage).click_my_account
  on(LoginPage) do |page|
    page.specify_credentials(CONFIG['admin'],CONFIG['admin_pwd'])
    page.submit_login
  end
  visit UsersPage
  on(UsersPage) do |page|
    page.specify_srch_user(CONFIG['user_r_email'])
    page.click_search
    page.delete_user(CONFIG['user_r_email'],true)
    sleep 2
    page.logout_admin
  end

  on(LoginPage).create_account
end
And(/^there are all required Sign Up controls\.$/) do
  on(SignUpPage) do |page|
    login_ctrls=%w(txtFirstName txtLastName txtEmail txtPwd txtPwdConfirm chkNewsletter btnCreateAccount lnkSignIn)
    expect(login_ctrls.inject([]){|arr, n| arr << page.send("#{n}_element") }).to all(be_visible)
  end
end

#~~~ Create a new account. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Then(/^I want to create a new account\.$/) do
  on(SignUpPage) do |page|
    page.specify_first_name(CONFIG['user_fname'])
    page.specify_last_name(CONFIG['user_lname'])
    page.specify_email(CONFIG['user_r_email'])
    page.specify_passwords(CONFIG['user_pwd'])
    page.newsletter(false)
    page.click_create_an_account
  end
end
And(/^be sure a new account was created\.$/) do
  on(HomePage) do |page|
    page.click_my_account
    expect(page.current_url).to include('/profile')
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Create a new account from Forgot Password form. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Then(/^I want to go to Sign Up form from it\.$/) do
  pending
end
And(/^create a new account\.$/) do
  pending
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Check all Sign Up form elements. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



