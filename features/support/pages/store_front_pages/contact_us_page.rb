require_relative '../../pages/store_front_pages/modules/header'
require_relative '../../pages/store_front_pages/modules/footer'

class ContactUsPage
  include PageObject
  include Header
  include Footer

  page_url(CONFIG['base_url']+'/contact')

  text_field(:txtFirstName,id: 'contact_first_name')
  text_field(:txtLastName,id: 'contact_last_name')
  text_field(:txtEmail ,id: 'contact_email')
  select_list(:sltCountryCode, id: 'country_code')
  text_field(:txtPhone ,id: 'contact_phone')
  select_list(:sltCanWeHelp, id: 'can_we_help')
  select_list(:sltCategory, id: 'contact_subject')

  text_area(:txtEnquiry ,id: 'contact_message')
  button(:btnSubmit, name: 'commit')

end