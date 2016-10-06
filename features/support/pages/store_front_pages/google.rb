class Gmail
  include PageObject

  page_url "http://gmail.com"
  inbox_url = 'https://mail.google.com/mail/#inbox'

  text_field(:txtEmail, id: 'Email')
  button(:btnNext, id: 'next')
  text_field(:txtPasswd, id: 'Passwd')
  button(:btnSignInGmail, id: 'signIn')
  span(:spnFandPemail, xpath: "//span[contains(text(),'reset your password')]")
  link(:lnkResetPwd, xpath: "//a[contains(text(),'https://')]")

  def specify_gmail(gmail)
    self.txtEmail_element.when_present.set(gmail)
  end

  def goto_inbox
    @browser.goto 'https://mail.google.com/mail/#inbox'
  end

  def go_next
    self.btnNext_element.when_present.click
  end

  def specify_gpwd(gpwd)
    self.txtPasswd_element.when_present.set(gpwd)
  end

  def sign_in_gmail
    self.btnSignInGmail_element.when_present.click
  end

  def open_res_email
    self.spnFandPemail_element.when_present(60).click
  end

  def click_reset_link
    self.lnkResetPwd_element.when_present(60).click
  end

end