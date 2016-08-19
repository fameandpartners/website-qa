require_relative '../../pages/store_front_pages/modules/header'

class MyProfilePage
  include PageObject
  include Header

  page_url(CONFIG['base_url']+'/profile')

  span(:tabAccSettings, xpath: "//span[contains(text(),'Account')]")










end