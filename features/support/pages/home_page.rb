require_relative '../pages/modules/header'

class HomePage
  include PageObject
  include HeaderPart

  page_url(CONFIG['base_url'])

end