module Header
  include PageObject

  span(:spnMyAccount, xpath: "//span[@class='my-account']")
  link(:lnkMyOrders, href: '/user_orders')
  link(:lnkMyMoodboards, href: '/wishlist')
  link(:lnkMyDetails, href: '/profile')
  link(:lnkLogout, href: '/logout')

  def click_my_account
    self.spnMyAccount_element.when_present.click
  end

  def hover_my_account
    self.spnMyAccount_element.when_present.hover
  end

  def click_logout
    self.lnkLogout_element.when_present.hover
  end
end