module Product
  include PageObject

  div(:divDressSize, text: 'Dress Size')
  div(:divSkirtLength, text: 'Skirt Length')


  div(:divProductPrice, xpath: "//div[@class='price']")
  link(:lnkAddToBag, text: 'ADD TO BAG')

  def open_dress_size
    self.divDressSize_element.when_present.click
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