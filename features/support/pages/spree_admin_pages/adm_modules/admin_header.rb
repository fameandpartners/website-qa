module AdminHeader
  include PageObject

  link(:lnkAccount, text: 'Account')
  link(:lnkLogout, text: 'Logout')
  link(:lnkStore, text: 'Store')

  link(:tabOrders, link: '/spree_admin/orders')
  link(:tabProds, link: '/spree_admin/products')
  link(:tabReports, link: '/spree_admin/reports')
  link(:tabFame, link: '/fame_admin/')
  link(:tabConfig, link: '/spree_admin/general_settings/edit')
  link(:tabSales, link: '/spree_admin/sales')
  link(:tabPromotions, link: '/spree_admin/promotions')
  link(:tabBanners, link: '/spree_admin/banner_boxes')
  link(:tabUsers, link: '/spree_admin/users')

  def logout_admin
    self.lnkLogout_element.when_present.click
  end


end


