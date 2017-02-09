class CustomerIO
  include PageObject

  page_url(CONFIG['customer_io_url'])

  text_field(:txtCioLogin, id:'user_email')
  text_field(:txtCioPwd, id:'user_password')
  button(:btnCioSignin, value:'Sign in')

  def specify_cio_login(login)
    self.txtCioLogin_element.value = login
  end

  def specify_cio_pwd(pwd)
    self.txtCioPwd_element.value = pwd
  end

  def click_cio_signin
    self.btnCioSignin_element.when_present.click
  end

  def goto_cio_url(url)
    @browser.goto(CONFIG['customer_io_url']+url)
  end

  def open_email(subject, order)
    self.link_element(text:"#{subject} #{order}").when_present(30).click
  end
end