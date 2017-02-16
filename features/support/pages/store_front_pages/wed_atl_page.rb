class WeddingAtelier < MainBasePage

  link(:lnkSignUp, href:'/wedding-atelier/signup')
  link(:lnkSignIn, href:'/wedding-atelier/sign_in')

  # Sign In form ~~~~~~~~~~~~~~~~~~~
  text_field(:txtEmail, id:'spree_user_email')
  text_field(:txtPwd, id:'spree_user_password')
  button(:btnSignIn, value:'Sign in')
  link(:btnForgotPwd, href:'/spree_user/password/new')

  # Sign Up form ~~~~~~~~~~~~~~~~~~~
  text_field(:txtFirstName, id:'spree_user_first_name')
  text_field(:txtLastName, id:'spree_user_last_name')
  text_field(:txtUserEmail, id:'spree_user_email')
  text_field(:txtUserPwd, id:'spree_user_password')
  button(:btnNext, value:'Next')


  def open_sing_in_up(sign_type)
    case sign_type
      when 'Signup'
        self.lnkSignUp_element.when_present(30).click
      when 'Singin'
        self.lnkSignIn_element.when_present(30).click
    end
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
  def specify_credentials(user_email, user_pwd)
    self.txtEmail_element.value = user_email
    self.txtPwd_element.value = user_pwd
  end
  def sign_in_wed_atl
    self.btnSignIn_element.when_present.click
  end

  def specify_user_first_name(first_name)
    self.txtFirstName_element.value = first_name
  end

  def specify_user_last_name(last_name)
    self.txtLastName_element.value = last_name
  end

  def specify_user_email(email)
    self.txtUserEmail_element.value = email
  end

  def specify_user_pwd(pwd)
    self.txtUserPwd_element.value = pwd
  end

  def click_next
    self.btnNext_element.when_present(30).click
  end


  def send_invitation(sts)
    case sts
      when true

      when false
    end
  end








end