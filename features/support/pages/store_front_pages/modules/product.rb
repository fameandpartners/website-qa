module Product
  include PageObject

  div(:divDressSize, text: 'Dress Size')
  div(:divSkirtLength, text: 'Height & Hemline')

  div(:divProductPrice, xpath: "//div[@class='price']")
  link(:lnkAddToBag, text: 'ADD TO BAG')

  def open_dress_size
      sleep 3 #for safari
      # self.div_element(xpath: ".//*[@id='tab-size-fit']/div[1]/a/div[1]").when_present.click
      self.div_element(xpath: ".//div[@id='tab-size-fit']/div[contains(@class,'pdp-side')]/a/div[text()='Dress Size']").when_present.click
  end

  def select_dress_size(size)
    self.divDressSize_element.wait_until_present
    self.link_element(xpath: "//a[contains(text(),'#{size}')]").when_present.click
  end

  def open_skirt_length
    self.divSkirtLength_element.when_present.click
  end

  def select_skirt_length(length)
    self.divSkirtLength_element.wait_until_present
    self.link_element(xpath: "//a[contains(text(),'#{length}')]").when_present.click
  end


  def add_to_bag
    self.lnkAddToBag_element.when_present.click
  end

end