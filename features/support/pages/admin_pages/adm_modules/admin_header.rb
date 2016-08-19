module AdminHeader
  include PageObject

  link(:lnkAccount, text: 'Account')
  link(:lnkLogout, text: 'Logout')
  link(:lnkStore, text: 'Store')

  link(:tabOrders, link: '/admin/orders')
  link(:tabProds, link: '/admin/products')
  link(:tabReports, link: '/admin/reports')
  link(:tabFame, link: '/fame_admin/')
  link(:tabConfig, link: '/admin/general_settings/edit')
  link(:tabSales, link: '/admin/sales')
  link(:tabPromotions, link: '/admin/promotions')
  link(:tabBanners, link: '/admin/banner_boxes')
  link(:tabUsers, link: '/admin/users')

  def logout_admin
    self.lnkLogout_element.when_present.click
  end


end


