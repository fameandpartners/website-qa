module HeaderPart
  include PageObject

  span(:spnMyAccount, xpath: "//span[@class='my-account']")


  def click_my_account
    self.spnMyAccount_element.when_present.click
  end

  def hover_my_account
    self.spnMyAccount_element.when_present.hover
  end

end