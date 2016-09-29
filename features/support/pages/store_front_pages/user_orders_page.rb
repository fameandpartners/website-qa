class UserOrdersPage < BasePage


  page_url(CONFIG['base_url']+'/user_orders')

  table(:tblOrdersTable, xpath: "//table[contains(@class,'orders-table')]")


end