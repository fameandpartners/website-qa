class ForgotPwdPage < BasePage

  page_url(CONFIG['base_url']+'/spree_user/password/new')

  h1(:hForgotPwd, xpath: "//h1[text()='Forgot Password?']")
  label(:lblEmail, xpath: "//input[@id='spree_user_email']/../label[@for='spree_user_email']")
  text_field(:txtEmail, id: 'spree_user_email')
  button(:btnReset, value: "Reset my password")
  link(:lnkCreateAcc, text: 'Create a new account')
  link(:lnkSignIn, text: 'Sign in')


  def specify_email(email)
    self.txtEmail_element.when_present.set(email)
  end

  def click_reset
    self.btnReset_element.when_present.click
  end

  def create_new_account
    self.lnkCreateAcc_element.when_present.click
  end

  def sign_in_gmail
    self.lnkSignIn_element.when_present.click
  end






end