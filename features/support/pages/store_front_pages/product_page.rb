require_relative '../../pages/store_front_pages/modules/header'
require_relative '../../pages/store_front_pages/modules/product'

class ProductPage
  include PageObject
  include Header
  include Product

  page_url(CONFIG['base_url']+'/dresses/dress-kirrily-1100')




end