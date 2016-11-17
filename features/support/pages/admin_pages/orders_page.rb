class OrdersPage < BasePage

  page_url(CONFIG['base_url']+'/admin/orders')

  text_field(:txtUserSearch, id: 'q_number_cont')
  button(:btnFilterResult, xpath: "//form[@id='spree/order_search']//button[@class='icon-search button']")

  table(:tblOrderDetails, xpath: "//thead[@id='line-items']/..")
  # Order's right panel ~~~~~~~~~~~~~~~~~~
  span(:spnOrderDetails, text: 'Order Details')
  span(:spnCustomerDetails, text: 'Customer Details')
  span(:spnAdjustments, text: 'Adjustments')
  span(:spnPayments, text: 'Payments')
  span(:spnShipments, text: 'Shipments')
  span(:spnReturnAuthorizations, text: 'Return Authorizations')
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Adjustment tab ~~~~~~~~~~~~~~~~~~~~~~~
  table(:tblAdjustments, xpath: "//table[@data-hook='adjustments']")
  link(:lnkNewAdjustment, text:'New Adjustment')
  text_field(:txtAdjustmentAmount, id: 'adjustment_amount')
  text_field(:txtAdjustmentDescription, id: 'adjustment_label')
  button(:btnContinue, text: 'Continue')
  button(:btnCancel, text: 'Cancel')
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  def specify_search_order(order_num)
    self.txtUserSearch_element.when_present.set(order_num)
  end

  def filter_results
    self.btnFilterResult_element.when_present.click
  end

  def open_adjustments
    self.spnAdjustments_element.when_present.click
  end

  def open_order_details
    self.spnOrderDetails_element.when_present.click
  end

  def new_adjustment
    self.lnkNewAdjustment_element.when_present.click
  end
  def specify_adjustment_amount(amount)
    self.txtAdjustmentAmount_element.when_present.set(amount)
  end

  def specify_adjustment_description(description)
    self.txtAdjustmentDescription_element.when_present.set(description)
  end

  def continue_adjustment
    self.btnContinue_element.when_present.click
  end

  def cancel_adjustment
    self.btnCancel_element.when_present.click
  end

  def delete_adjustment(confirm)
    self.link_element(xpath: "//td[text()='Test adjustment description']/..//a[@data-action='remove']").when_present.click
    case confirm
      when true
        @browser.alert.ok
      when false
        @browser.alert.close
    end
  end

end
