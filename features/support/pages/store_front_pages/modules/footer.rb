module Footer
  include PageObject

  link(:lnkContactUs, xpath: "//footer[@class='main js-footer']//a[@href='https://staging.fameandpartners.com/contact']")


  def open_contact_us
    self.lnkContactUs_element.when_visible.click
  end


end