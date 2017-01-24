#~~~ Open Sign Up form. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When(/^I open "Sign Up" form\.$/) do
  on(HomePage).click_my_account
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
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    page.specify_first_name(first_name)
    page.specify_last_name(last_name)
    @new_user_email = "#{SecureRandom.uuid}@lorem.com"
    page.specify_email(@new_user_email)
    page.specify_passwords('1qazxcv')
    page.specify_confirm_passwords('1qazxcv')
    page.newsletter(false)
    page.click_create_an_account
  end
end
And(/^be sure a new account was created\.$/) do
  on(HomePage) do |page|
    page.click_my_account
    expect(page.current_url).to include('/profile')
  end
  on(LogoutPage).visit_site_version(country: 'USA', url: '/logout')
  on(HomePage).visit_site_version(country: 'USA', url: '/login')
  on(LoginPage) do |page|
    page.specify_credentials(CONFIG['spree_admin'],CONFIG['admin_pwd'])
    page.submit_login
  end
  visit UsersPage
  on(UsersPage) do |page|
    page.specify_srch_user(@new_user_email)
    page.click_search
    expect(page.link_element(xpath: "//a[text()='#{@new_user_email}']").visible?).to be_truthy
  end

end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Create a new account from Forgot Password form. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Then(/^I want to go to "Sign Up" form from it\.$/) do
  on(ForgotPwdPage).create_new_account
end

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ Check all Sign Up form elements. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



