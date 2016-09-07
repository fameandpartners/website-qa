require_relative '../../pages/store_front_pages/modules/header'


class LoginPage
  include PageObject
  include Header


  page_url(CONFIG['base_url']+'/spree_user/sign_in')

  h1(:hLogin, xpath: "//h1[text()='Login']")
  link(:lnkFaceBook, xpath: "//a[text()='Log in with Facebook']")
  span(:spnOr, xpath: "//span[text()='or']")
  label(:lblEmail, xpath: "//input[@id='spree_user_email']/../label[@for='spree_user_email']")
  text_field(:txtEmail, id: 'spree_user_email')
  label(:lblPwd, xpath: "//input[@id='spree_user_password']/../label[@for='spree_user_password']")
  text_field(:txtPwd, id: 'spree_user_password')
  checkbox(:chkRemMe, id: 'spree_user_remember_me')
  span(:spnRemMe, xpath: "//label[@for='spree_user_remember_me']/span[text()='Remember me']")
  button(:btnLogin, xpath: "//input[@value='Login']")
  link(:lnkCreateAcc, text: 'Create a new account')
  link(:lnkForgotPwd, text: 'Forgot Password?')
  h3(:spnResetPwdNtf, text: "You will receive an email with instructions about how to reset your password in a few minutes.")
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  def open_login_form

  end




  def specify_email(email)
    self.txtEmail_element.when_present.set(email)
  end


  def specify_pwd(pwd)
    self.txtPwd_element.when_present.set(pwd)
  end

  def specify_credentials(user_email, user_pwd)
    self.txtEmail_element.when_present.set(user_email)
    self.txtPwd_element.when_present.set(user_pwd)
  end

  def submit_login
    self.btnLogin_element.when_present.click
  end

  def remember_me(rem_me)
    case rem_me
      when true
        self.chkRemMe_element.set
      when false
        self.chkRemMe_element.clear
    end
  end

  def create_account
    self.lnkCreateAcc_element.when_present.click
  end

  def open_forgot_pwd
    self.lnkForgotPwd_element.when_present.click
  end

end