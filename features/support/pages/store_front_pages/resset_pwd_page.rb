class ForgotPwdPage < MainBasePage

  page_url(CONFIG['base_url']+'/spree_user/password/new')

  h1(:hForgotPwd, xpath: "//h1[text()='Forgot Password?']")
  label(:lblEmail, xpath: "//input[@id='spree_user_email']/../label[@for='spree_user_email']")
  text_field(:txtEmail, id: 'spree_user_email')
  button(:btnReset, value: "Reset my password")
  link(:lnkCreateAcc, text: 'Create a new account')
  link(:lnkSignIn, text: 'Sign in')

  text_field(:txtPwdReset, id: 'spree_user_password')
  text_field(:txtPwdResetConfirm, id: 'spree_user_password_confirmation')
  button(:btnChangePwd, value: 'Change Password')

  def specify_email(email)
    self.txtEmail_element.when_present.set(email)
  end

  def specify_new_pwd(new_pwd)
    self.txtPwdReset_element.when_present.set(new_pwd)
  end

  def specify_new_pwd_confirm(new_pwd_confirm)
    self.txtPwdResetConfirm_element.when_present.set(new_pwd_confirm)
  end

  def click_change_pwd
    self.btnChangePwd_element.when_present.click
  end

  def click_reset
    self.btnReset_element.when_present.click
  end

  def create_new_account
    self.lnkCreateAcc_element.when_present.click
  end

  def sign_in_link
    self.lnkSignIn_element.when_present.click
  end






end