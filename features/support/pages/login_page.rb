require_relative '../pages/modules/header'

class LoginPage
  include PageObject
  include HeaderPart

  page_url(CONFIG['base_url']+'/spree_user/sign_in')

  text_field(:txtEmail, id: 'spree_user_email')
  text_field(:txtPassword, id: 'spree_user_password')
  button(:btnLogin, xpath: "//input[@value='Login']")

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  def open_login_form

  end

  def specify_credentials(user_email, user_pwd)
    self.txtEmail_element.when_present.set(user_email)
    self.txtPassword_element.when_present.set(user_pwd)
  end

  def submit_login
    self.btnLogin_element.when_present.click
  end



end