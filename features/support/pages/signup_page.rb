require_relative '../pages/modules/header'

class LoginPage
  include PageObject
  include HeaderPart

  page_url(CONFIG['base_url']+'/signup')

  # h1(:hLogin, xpath: "//h1[text()='Login']")
  # link(:lnkFaceBook, xpath: "//a[text()='Log in with Facebook']")
  # span(:spnOr, xpath: "//span[text()='or']")
  # label(:lblEmail, xpath: "//input[@id='spree_user_email']/../label[@for='spree_user_email']")
  # text_field(:txtEmail, id: 'spree_user_email')
  # label(:lblPwd, xpath: "//input[@id='spree_user_password']/../label[@for='spree_user_password']")
  text_field(:txtFirstName, id: 'spree_user_first_name')
  text_field(:txtLastName, id: 'spree_user_last_name')
  text_field(:txtEmail, id: 'spree_user_email')
  text_field(:txtPwd, id: 'spree_user_password')
  text_field(:txtPwdConfirm, id: 'spree_user_password_confirmation')
  # checkbox(:chkRemMe, id: 'spree_user_remember_me')
  # span(:spnRemMe, xpath: "//label[@for='spree_user_remember_me']/span[text()='Remember me']")
  # button(:btnLogin, xpath: "//input[@value='Login']")
  # link(:lnkCreateAcc, text: 'Create a new account')
  # link(:lnkForgotPwd, text: 'Forgot Password?')





















end