require_relative '../../pages/admin_pages/adm_modules/admin_header'

class OrdersPage
  include PageObject
  include AdminHeader

  page_url(CONFIG['base_url']+'/admin/orders')

  text_field(:txtUserSearch, id: 'q_number_cont')
  button(:btnFilterResult, xpath: "//form[@id='spree/order_search']//button[@class='icon-search button']")
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  def specify_search_order(order_num)
    self.txtUserSearch_element.when_present.set(order_num)
  end


  def filter_results
    self.btnFilterResult_element.when_present.click
  end


end
