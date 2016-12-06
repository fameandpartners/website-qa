class SignUpPage < MainBasePage

  page_url(CONFIG['base_url']+'/signup')


  link(:lnkSignUpFaceBook, xpath: "//a[text()='Log in with Facebook']")

  text_field(:txtFirstName, id: 'spree_user_first_name')
  text_field(:txtLastName, id: 'spree_user_last_name')
  text_field(:txtEmail, id: 'spree_user_email')
  text_field(:txtPwd, id: 'spree_user_password')
  text_field(:txtPwdConfirm, id: 'spree_user_password_confirmation')
  checkbox(:chkNewsletter, id: 'spree_user_newsletter')
  button(:btnCreateAccount, xpath: "//input[@value='Create an account']")
  link(:lnkSignIn, text: 'Sign in')



  def specify_first_name(f_name)
    self.txtFirstName_element.when_present.set(f_name)
  end

  def specify_last_name(l_name)
    self.txtLastName_element.when_present.set(l_name)
  end

  def specify_email(email)
    self.txtEmail_element.when_present.set(email)
  end

  def specify_passwords(pwd)
    self.txtPwd_element.when_present.set(pwd)
    self.txtPwdConfirm_element.when_present.set(pwd)
  end

  def click_create_an_account
    self.btnCreateAccount_element.when_present.click
  end

  def newsletter(news_letter)
    case news_letter
      when true
        self.chkNewsletter_element.when_present.set
      when false
        self.chkNewsletter_element.when_present.clear
    end
  end












end