class CheckOutPage
  include PageObject

  page_url(CONFIG['base_url']+'/checkout')

  # "Your information" step.
  text_field(:txtEmail, id: 'order_bill_address_attributes_email')
  text_field(:txtFirstName, id: 'order_bill_address_attributes_firstname')
  text_field(:txtLastName, id: 'order_bill_address_attributes_lastname')
  text_field(:txtStreetAddress, id: 'order_bill_address_attributes_address1')
  text_field(:txtStreetAddressContd, id: 'order_bill_address_attributes_address2')


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
  button(:txtPlaceOrder, text: 'Place My Order')




    def specify_email(email:)
      self.txtEmail_element.when_present.set(email)
    end

  def fill_in_credit(data={})
    self.txtCardNumber_element.when_present.set(data['Card number'])
    self.txtNameOnCard_element.when_present.set(data['Name on card'])
    self.txttxtExpMonth_element.when_present.set(data['Expiration Month'])
    self.txtExpYear_element.when_present.set(data['Expiration Year'])
    self.txtCVC_element.when_present.set(data['CVC'])
  end


  def ship_address(variant)
    case variant
      when 'current'
        self
      when 'different'
        self
    end
  end

  def pay_securely
    self.btnPaySecurely_element.when_present.click
  end

end