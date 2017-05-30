class SalesPage < MainBasePage

  link(:lnkNewSale, id:'admin_new_sale')
  text_field(:txtSaleName, id:'sale_name')
  text_field(:txtSitewideMsg, id:'sale_sitewide_message')
  checkbox(:chkIsActive, id:'sale_is_active')
  checkbox(:chkSitewide, id:'sale_sitewide')
  checkbox(:chkCustomAllow, id:'sale_customisation_allowed')
  text_field(:txtDiscountSize, id:'sale_discount_size')
  select_list(:sltDiscountType, id:'sale_discount_type')
  select_list(:sltCurrency, id:'sale_currency')
  button(:btnCreateSale, text:'Create')









  def click_new_sale
    self.lnkNewSale_element.when_present(30).click
  end

  def specify_sale_name(sale_name)
    self.txtSaleName_element.value = sale_name
  end

  def specify_sitewide_message(sitewide_msg)
    self.txtSitewideMsg_element.value = sitewide_msg
  end

  def activate_sale(sale_sts)
    case sale_sts
      when true
        self.chkIsActive_element.check
      when false
        self.chkIsActive_element.uncheck
    end
  end

  def make_sitewide(sitewide_sts)
    case sitewide_sts
      when true
        self.chkSitewide_element.check
      when false
        self.chkSitewide_element.uncheck
    end
  end

  def allow_customisation(customisation_sts)
    case customisation_sts
      when true
        self.chkCustomAllow_element.check
      when false
        self.chkCustomAllow_element.uncheck
    end
  end

  def specify_discount_size(discount_size)
    self.txtDiscountSize_element.value = discount_size
  end

  def select_discount_type(discount_type)
    self.sltDiscountType_element.select(discount_type)
  end

  def select_currency(currency)
    self.sltCurrency_element.select(currency)
  end

  def click_create_sale
    self.btnCreateSale_element.click
  end

  def delete_sale(sale_name, confirm)
    if self.cell_element(xpath: "//td[text()='#{sale_name}']").visible?
      self.link_element(xpath: "//td[text()='#{sale_name}']/..//a[@data-action='remove']").when_present(30).click
      case confirm
        when true
          @browser.alert.ok
        when false
          @browser.alert.close
      end
    end
  end

  def delete_all_sales
    while self.link_element(xpath:"//td[text()='Active']/..//a[contains(@class,'delete-resource')]").visible?
      self.link_element(xpath: "//td[text()='Active']/..//a[contains(@class,'delete-resource')]").when_present(30).click
      @browser.alert.ok
    end
  end

  def edit_sale(sale_name)
    self
  end


end