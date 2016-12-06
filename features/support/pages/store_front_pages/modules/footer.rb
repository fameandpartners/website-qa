module Footer
  include PageObject

  text_field(:txtSubscribe, xpath: "//form//input[@type='email']")
  button(:btnSubmitSubscribe, text: 'Submit')

  button(:btnCloseFooterPopup, text: 'X')

  link(:lnkWhyShopWithUs, link: '/why-us')


  link(:lnkWhyShopWithUs, link: '/why-us')
  link(:lnkWhyShopWithUs, link: '/why-us')
  link(:lnkWhyShopWithUs, link: '/why-us')
  link(:lnkWhyShopWithUs, link: '/why-us')
  link(:lnkWhyShopWithUs, link: '/why-us')
  link(:lnkWhyShopWithUs, link: '/why-us')
  link(:lnkWhyShopWithUs, link: '/why-us')
  link(:lnkWhyShopWithUs, link: '/why-us')
  link(:lnkWhyShopWithUs, link: '/why-us')
  link(:lnkWhyShopWithUs, link: '/why-us')
  link(:lnkWhyShopWithUs, link: '/why-us')
  link(:lnkWhyShopWithUs, link: '/why-us')
  link(:lnkWhyShopWithUs, link: '/why-us')
  link(:lnkWhyShopWithUs, link: '/why-us')
  link(:lnkWhyShopWithUs, link: '/why-us')



  link(:lnkContactUs, link: '')

  link(:lnkContactUs, xpath: "//footer[@class='main js-footer']//a[@href='https://staging.fameandpartners.com/contact']")


  def open_contact_us
    self.lnkContactUs_element.when_visible.click
  end

  def specify_subscribe_email(email)
    self.txtSubscribe_element.value = email
  end

  def subscribe_email
    self.btnSubmitSubscribe_element.when_present.click
  end

  def close_footer_popup
    self.btnCloseFooterPopup_element.when_present.click
  end

end