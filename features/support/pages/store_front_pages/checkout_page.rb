class CheckOutPage < MainBasePage


  page_url(CONFIG['base_url']+'/checkout')

  # "Deliver to" block.
  text_field(:txtEmail, id: 'order_ship_address_attributes_email')
  text_field(:txtFirstName, id: 'order_ship_address_attributes_firstname')
  text_field(:txtLastName, id: 'order_ship_address_attributes_lastname')
  text_field(:txtPhoneNumber, id: 'order_ship_address_attributes_phone') #new one



  # "Delivery Address" block.
  div(:divCountry, id: 'order_ship_address_attributes_country_id_chosen')
  text_field(:txtStreetAddress, id: 'order_ship_address_attributes_address1')
  text_field(:txtStreetAddressContd, id: 'order_ship_address_attributes_address2')
  text_field(:txtCity, id: 'order_ship_address_attributes_city')
  text_field(:txtZipcode, id: 'order_ship_address_attributes_zipcode')
  div(:divState, id: 'order_ship_address_attributes_state_id_chosen')
  text_field(:txtState, id: 'order_ship_address_attributes_state_name')
  label(:lblShipAddress, xpath: "//label[@for='ship_to_address']")

  button(:btnPaySecurely, name: 'pay_securely')
  label(:lblDutyFee, xpath: "//label[@for='international_shipping_fee']")
  # "Billing Address" balock.
  span(:spnBillingAddress, xpath: "//span[text()='Billing Address']")



  # "Payment Method" step.
  text_field(:txtCardNumber, id: 'number')
  text_field(:txtNameOnCard, id: 'name')
  text_field(:txtExpMonth, id: 'month')
  text_field(:txtExpYear, id: 'year')
  text_field(:txtCVC, id: 'card_code')
  button(:btnPlaceOrder, text: 'Place your order now')


  # Right checkout panel
  text_field(:txtCoupon, xpath: "//div[contains(@class,'hidden-sm')]//input[@placeholder='Discount code']")
  button(:btnApplyCoupon, xpath: "//div[contains(@class,'hidden-sm')]//button")

  h1(:hOrderThanks, xpath: "//h1[@class='order']")

  # Fee popup
  button(:btnCross, xpath: "//div[@class='vex-dialog-message']//button[text()='X']")
  button(:btnOK, xpath: "//div[@class='vex-dialog-message']//button[text()='OK']")


  # 1. Your information methods:
  def specify_email(email:)
    self.txtEmail_element.value = email
  end
  # 2. Address Details methods:
  def specify_first_name(fname:)
    self.txtFirstName_element.value = fname
  end
  def specify_last_name(lname:)
    self.txtLastName_element.value = lname
  end
  def specify_street_address(street:)
    self.txtStreetAddress_element.value = street
  end
  def specify_street_address_contd(street_cnd:)
    self.txtStreetAddressContd_element.value = street_cnd
  end
  def select_country(country:)
    @browser.scroll.to :center
    self.divCountry_element.when_present.click
    self.list_item_element(xpath: "//li[text()='#{country}']").when_present.click
  end

  def select_state(state:)
    if self.txtState_element.visible?
      self.txtState_element.when_present.set(state)
    end
    if self.divState_element.visible?
      self.divState_element.when_present.click
      self.list_item_element(xpath: "//li[text()='#{state}']").when_present.click
    end
  end

  def specify_city(city:)
    self.txtCity_element.value = city
  end
  def specify_phone_num(phone_num:)
    self.txtPhoneNumber_element.value = phone_num
  end
  def zipcode(zipcode:)
    self.txtZipcode_element.value = zipcode
  end

  def select_ship_address(variant)
    case variant
      when false
        unless self.spnBillingAddress_element.visible?
          self.lblShipAddress_element.when_present.click
        end
      when true
        if self.spnBillingAddress_element.visible?
          self.lblShipAddress_element.when_present.click
        end
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
    self.txtNameOnCard_element.value = data['Name on card']
    self.txtCardNumber_element.value = data['Card number']
    self.txtExpMonth_element.value = data['Expiration Month']
    self.txtExpYear_element.value = data['Expiration Year']
    self.txtCVC_element.value = data['CVC']
  end

  def place_my_order
    self.btnPlaceOrder_element.when_present.click
  end

  def confirm_custom_duty_fees(fee)
    case fee
      when true
        if self.btnPaySecurely_element.attribute_value('disabled')
          self.lblDutyFee_element.when_present.click
        end
      when false
        self.lblDutyFee_element.when_present.clear
    end
  end

  def specify_coupon(coupon)
    self.txtCoupon_element.value = coupon
  end

  def apply_coupon
    self.btnApplyCoupon_element.when_present.click
  end

end