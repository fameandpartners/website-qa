class LogoutPage
  include PageObject
  include Header

  page_url(CONFIG['base_url']+'/logout')

end
