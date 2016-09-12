class CheckOutPage
  include PageObject

  page_url(CONFIG['base_url']+'/checkout')

  # "Your information" step.
  text_field(:txtEmail, id: 'order_bill_address_attributes_email')
  text_field(:txtFirstName, id: 'order_bill_address_attributes_firstname')
  text_field(:txtLastName, id: 'order_bill_address_attributes_lastname')
  text_field(:txtStreetAddress, id: 'order_bill_address_attributes_address1')
  text_field(:txtStreetAddressContd, id: 'order_bill_address_attributes_address2')
  div(:divCountry, id: 'order_bill_address_attributes_country_id_chosen')
  div(:divState, id: 'order_bill_address_attributes_state_id_chosen')

  text_field(:txtCity, id: 'order_bill_address_attributes_city')
  text_field(:txtPhoneNumber, id: 'order_bill_address_attributes_phone')
  text_field(:txtZipcode, id: 'order_bill_address_attributes_zipcode')
  radio_button(:rdbShipAddress, id: 'ship_to_address_Ship_to_this_address')
  radio_button(:rdbShipDifferentAddress, id: 'ship_to_address_Ship_to_a_different_address')
  button(:btnPaySecurely, name: 'pay_securely')

  # "Payment Method" step.
  text_field(:txtCardNumber, id: 'number')
  text_field(:txtNameOnCard, id: 'name')
  text_field(:txtExpMonth, id: 'month')
  text_field(:txtExpYear, id: 'year')
  text_field(:txtCVC, id: 'card_code')
  button(:btnPlaceOrder, text: 'Place My Order')


  # Right checkout panel
  text_field(:txtCity, id: 'order_bill_address_attributes_city')

  h1(:hOrderThanks, xpath: "//h1[@class='order']")

  # Fee popup
  button(:btnCross, xpath: "//div[@class='vex-dialog-message']//button[text()='X']")
  button(:btnOK, xpath: "//div[@class='vex-dialog-message']//button[text()='OK']")


  # 1. Your information methods:
  def specify_email(email:)
    self.txtEmail_element.when_present.set(email)
  end
  # 2. Address Details methods:
  def specify_first_name(fname:)
    self.txtFirstName_element.when_present.set(fname)
  end
  def specify_last_name(lname:)
    self.txtLastName_element.when_present.set(lname)
  end
  def specify_street_address(street:)
    self.txtStreetAddress_element.when_present.set(street)
  end
  def specify_street_address_contd(street_cnd:)
    self.txtStreetAddressContd_element.when_present.set(street_cnd)
  end
  def select_country(country:)
    @browser.scroll.to :center
    self.divCountry_element.when_present.click
    self.list_item_element(xpath: "//li[text()='#{country}']").when_present.click
  end
  def select_state(state:)
    self.divState_element.when_present.click
    self.list_item_element(xpath: "//li[text()='#{state}']").when_present.click
  end
  def specify_city(city:)
    self.txtCity_element.when_present.set(city)
  end
  def specify_phone_num(phone_num:)
    self.txtPhoneNumber_element.when_present.set(phone_num)
  end
  def zipcode(zipcode:)
    self.txtZipcode_element.when_present.set(zipcode)
  end
  def select_ship_address(variant)
    case variant
      when 'Ship to this address'
        self.rdbShipAddress_element.when_present.set
      when 'Ship to different address'
        self.rdbShipDifferentAddress_element.when_present.set
    end
  end
  def pay_securely
    self.btnPaySecurely_element.when_present.click
  end

  # 3. Choose your payment method
  def close_fee_popup
    if self.btnOK_element.present?
      self.btnOK_element.when_present.click
    end
  end

  def fill_in_credit(data={})
    self.txtCardNumber_element.when_present.set(data['Card number'])
    self.txtNameOnCard_element.when_present.set(data['Name on card'])
    self.txtExpMonth_element.when_present.set(data['Expiration Month'])
    self.txtExpYear_element.when_present.set(data['Expiration Year'])
    self.txtCVC_element.when_present.set(data['CVC'])
  end

  def place_my_order
    self.btnPlaceOrder_element.when_present.click
  end



end