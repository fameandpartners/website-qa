require_relative '../pages/modules/header'

class LoginPage
  include PageObject
  include HeaderPart

  page_url(CONFIG['base_url']+'/spree_user/sign_in')

  text_field(:txEmail, id: 'spree_user_email')
  text_field(:txtPassword, id: 'spree_user_password')
  button(:btnLogin, xpath: "//input[@value='Login']")

  # link(:lnkLogin, :xpath => "//a[contains(text(),'Login')]")
  # link(:lnkSignUp, :xpath => "//a[contains(text(),'Sign Up')]")

  # link(:lnkSignUpEmail, :id => '#signup-email-btn')

  # text_field(:txtFirstName, :xpath => "//input[@placeholder='First name']")

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  def open_login_form

  end

  def specify_credentials(user_email, user_pwd)
    self.txEmail = user_email
    self.txtPassword = user_pwd
  end

  def submit_login
    self.btnLogin_element.when_present.click
  end



end