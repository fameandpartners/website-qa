require_relative '../pages/modules/header'

class ForgotPwdPage
  include PageObject
  include HeaderPart

  page_url(CONFIG['base_url']+'/spree_user/password/new')

  h1(:hForgotPwd, xpath: "//h1[text()='Forgot Password?']")
  label(:lblEmail, xpath: "//input[@id='spree_user_email']/../label[@for='spree_user_email']")
  text_field(:txtEmail, id: 'spree_user_email')
  button(:btnReset, value: "Reset my password")
  link(:lnkCreateAcc, text: 'Create a new account')
  link(:lnkSignIn, text: 'Sign in')


  def create_new_account
    self.lnkCreateAcc_element.when_present.click
  end

  def sign_in
    self.lnkSignIn_element.when_present.click
  end






end