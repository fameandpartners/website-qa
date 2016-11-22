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

  div(:divHomeMenu, id: 'home-menu')
  image(:imgLogo, src: 'https://d3uvjcfk5ey2fu.cloudfront.net/assets/logo/new-logo-ad36b2761e48c30c432a93f99e7df38a.svg')
  div(:divNavMainMenu, xpath: "//div[contains(@class,'nav-main-menu')]")
    div(:divNewThisWeek, id: 'rect-new-this-week')
    div(:divShop, id: 'rect-dresses')
    div(:divFameWeddings, id: 'rect-wedding')
    div(:divLookbooks, id: 'rect-lookbook')
  link(:lnkSearch, xpath: "//a[contains(@class,'icon-search')]")
  text_field(:txtSearch, id: 'searchValue')
  link(:lnkWishlist, href: '/moodboards')
  link(:lnkShoppingCart, xpath: "//div[@id='home-menu']//a[contains(@class,'shopping-cart')]")

  def click_my_account
    self.spnMyAccount_element.when_present.click
  end

  def hover_my_account
    self.spnMyAccount_element.when_present.hover
  end

  def click_logout
    self.lnkLogout_element.when_present.click
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
        self.lnkMyMoodboards_element.when_present.click
      when 'orders'
        self.lnkMyOrders_element.when_present.click
    end
  end

  def click_nav_menu(nav_menu_item)
    self.span_element(text: nav_menu_item).when_present.click
  end


end