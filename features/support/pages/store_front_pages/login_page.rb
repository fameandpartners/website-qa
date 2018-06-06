class LoginPage < MainBasePage

  page_url(CONFIG['base_url']+'/login')

  h1(:hLogin, xpath: "//h1[text()='Login']")
  link(:lnkFaceBook, xpath: "//a[text()='Log in with Facebook']")
  span(:spnOr, xpath: "//span[text()='or']")
  label(:lblEmail, xpath: "//input[@id='spree_user_email']/../label[@for='spree_user_email']")
  text_field(:txtEmail, id: 'spree_user_email')
  label(:lblPwd, xpath: "//input[@id='spree_user_password']/../label[@for='spree_user_password']")
  text_field(:txtPwd, id: 'spree_user_password')
  checkbox(:chkRemMe, id: 'spree_user_remember_me')
  span(:spnRemMe, xpath: "//label[@for='spree_user_remember_me']/span[text()='Remember me']")
  button(:btnLogin, name: 'commit')
  link(:lnkCreateAcc, text: 'Create a new account')
  link(:lnkForgotPwd, id: 'forgot-password')
  h3(:spnResetPwdNtf, text: "You will receive an email with instructions about how to reset your password in a few minutes.")
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Facebook login form ~~~~~~~~~~~~~~~~~~
  text_field(:txtFacebookEmail,id:'email')
  text_field(:txtFacebookPwd,id:'pass')
  button(:btnFacebookLogin,id:'loginbutton')

  def specify_email(email)
    self.txtEmail_element.value = email
  end

  def specify_pwd(pwd)
    self.txtPwd_element.value = pwd
  end

  # def specify_login_pwd(pwd)
  #   self.txtPwd_element.value =  pwd
  # end

  def open_facebook_login_form
    self.lnkFaceBook_element.when_present(30).click
  end

  def specify_registered_user(browser_name)
    if browser_name == 'chrome'
      self.specify_credentials(CONFIG['chrome_user'],CONFIG['chrome_user_pwd'])
    elsif browser_name == 'firefox'
      self.specify_credentials(CONFIG['firefox_user'],CONFIG['firefox_user_pwd'])
    elsif browser_name == 'internet explorer'
      self.specify_credentials(CONFIG['ie_user'],CONFIG['ie_user_pwd'])
    elsif browser_name == 'safari'
      self.specify_credentials(CONFIG['safari_user'],CONFIG['safari_user_pwd'])
    end
  end

  def specify_facebook_user(browser_name)
    if browser_name == 'chrome'
      self.specify_facebook_credentials(CONFIG['fb_chrome_user'],CONFIG['chrome_user_pwd'])
    elsif browser_name == 'firefox'
      self.specify_facebook_credentials(CONFIG['fb_firefox_user'],CONFIG['firefox_user_pwd'])
    elsif browser_name == 'internet explorer'
      self.specify_facebook_credentials(CONFIG['fb_ie_user'],CONFIG['ie_user_pwd'])
    elsif browser_name == 'safari'
      self.specify_facebook_credentials(CONFIG['fb_safari_user'],CONFIG['safari_user_pwd'])
    end
  end

  def specify_credentials(user_email, user_pwd)
    self.txtEmail_element.value = user_email
    self.txtPwd_element.value = user_pwd
  end

  def specify_facebook_credentials(user_email, user_pwd)
    self.txtFacebookEmail_element.value = user_email
    self.txtFacebookPwd_element.value = user_pwd
  end

  def submit_facebook_login
    self.btnFacebookLogin_element.when_present(30).click
  end

  def submit_login
    self.btnLogin_element.when_present(30).click
  end

  def remember_me(rem_me)
    case rem_me
      when true
        self.chkRemMe_element.check
      when false
        self.chkRemMe_element.clear
    end
  end

  def click_create_account
    self.lnkCreateAcc_element.when_present.click
  end

  def open_forgot_pwd
    self.lnkForgotPwd_element.when_present.click
  end

end