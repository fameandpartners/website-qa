module MobileFooter
  include PageObject

  text_field(:mtxtSubscribe, xpath: "//form//input[@type='email']")
  button(:mbtnSubmitSubscribe, text: 'Submit')

  button(:btnCloseFooterPopup, text: 'X')
  # "About" column
  link(:mlnkWhyShopWithUs, xpath: "//footer[@class='main js-footer']//a[@href='/why-us']")
  link(:mlnkAboutUs, xpath: "//footer[@class='main js-footer']//a[@href='/about']")
  link(:mlnkFameChain, xpath: "//footer[@class='main js-footer']//a[@href='/fame-chain']")
  link(:mlnkFromOurCEO, xpath: "//footer[@class='main js-footer']//a[@href='/from-our-ceo']")
  link(:mlnkPrivacyPolicy, xpath: "//footer[@class='main js-footer']//a[@href='/privacy']")
  link(:mlnkTerms, xpath: "//footer[@class='main js-footer']//a[@href='/terms']")
  # "Help" column
  link(:mlnkShippingInfo, xpath: "//footer[@class='main js-footer']//a[@href='/faqs#collapse-delivery-how-long']")
  link(:mlnkReturnsPolicy, xpath: "//footer[@class='main js-footer']//a[@href='/faqs#collapse-returns-policy']")
  link(:mlnkContactUs, xpath: "//footer[@class='main js-footer']//a[@href='https://staging.fameandpartners.com/contact']")
  link(:mlnkFAQ, xpath: "//footer[@class='main js-footer']//a[text()='FAQs']")
  link(:mlnkSizeGuide, xpath: "//footer[@class='main js-footer']//a[@href='/size-guide']")
  link(:mlnkTrackMyOrder, xpath: "//footer[@class='main js-footer']//a[@href='/faqs#collapse-orders-track']")




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