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
  select_list(:sltCanWeHelp, xpath: "//select[@id='can_we_help']")
  select_list(:sltCategory, id: 'contact_subject')

  text_area(:txtEnquiry ,id: 'contact_message')
  button(:btnSubmitEnquiry, name: 'commit')

  h1(:hThanks, text: "Thanks! We won't play hard to get, we'll get back to you ASAP.")

  def specify_first_name(fname:)
    self.txtFirstName_element.when_present.set(fname)
  end

  def specify_last_name(lname:)
    self.txtLastName_element.when_present.set(lname)
  end

  def specify_email(email:)
    self.txtEmail_element.when_present.set(email)
  end

  def select_country_code(cnt_code:)
    self.sltCountryCode_element.when_present.select(cnt_code)
  end

  def specify_phone_number(phone_number:)
    self.txtPhone_element.when_present.set(phone_number)
  end

  def select_can_we_help(help)
    self.sltCanWeHelp_element.when_present.select(help)
  end

  def select_category(category)
    self.sltCategory_element.when_present.select(category)
  end

  def type_enquiry(enquiry)
    self.txtEnquiry_element.when_present.set(enquiry)
  end

  def submit_enquiry
    self.btnSubmitEnquiry_element.when_present.click
  end


end