require_relative '../../pages/store_front_pages/modules/header'

class UserOrdersPage
  include PageObject
  include Header

  page_url(CONFIG['base_url']+'/user_orders')

  table(:tblOrdersTable, xpath: "//table[contains(@class,'orders-table')]")


end