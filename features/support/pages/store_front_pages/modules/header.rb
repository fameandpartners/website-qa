module Header
  include PageObject

  div(:divLocation, xpath: "//span[@id='locale-selector-container']//div[@id='locale-selector-current']")
  link(:lnkAUS, href: 'https://www.fameandpartners.com.au')
  link(:lnkUSA, href: 'https://www.fameandpartners.com')

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

  def click_locale_menu
    self.divLocation_element.when_present.click
  end

  def select_locale(locale)
    case locale
      when 'USA'
        self.link_element(xpath: "//span[@id='locale-selector-container']//a[contains(text(),'#{locale}')]").when_present.click
      when 'Australia'
        self.link_element(xpath: "//span[@id='locale-selector-container']//a[contains(text(),'#{locale}')]").when_present.click
    end
  end

  def open_account_submenu(submenu)
    case submenu
      when 'details'
        self.lnkMyDetails_element.when_present.click
      when 'moodboards'
      when 'orders'
    end
  end

end