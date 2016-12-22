module Product
  include PageObject

  div(:divDressSize, text: 'Dress Size')
  div(:divSkirtLength, text: 'Height & Hemline')

  div(:divProductPrice, xpath: "//div[@class='price']")
  link(:lnkAddToBag, text: 'ADD TO BAG')

  def open_dress_size
    self.div_element(xpath: "//div[text()='Dress Size']").when_present(30).click
  end


  def specify_your_size(dress_size:)
    self.divDressSize_element.wait_until_present
    self.link_element(xpath: "//a[contains(text(),'#{dress_size}')]").when_present(30).click
  end

  def specify_your_height_hemline(height_hemline:)
    self.divSkirtLength_element.wait_until_present
    self.link_element(xpath: "//a[contains(text(),'#{height_hemline}')]").when_present(30).click
  end

  def select_dress_size(size)
    self.divDressSize_element.wait_until_present
    self.link_element(xpath: "//a[contains(text(),'#{size}')]").when_present(30).click
  end

  def open_skirt_length
    self.divSkirtLength_element.when_present.click
  end

  def select_skirt_length(length)
    self.divSkirtLength_element.wait_until_present
    self.link_element(xpath: "//a[contains(text(),'#{length}')]").when_present(30).click
  end

  def add_to_bag
    self.lnkAddToBag_element.when_present(30).click
  end

end