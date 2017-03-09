module Product
  include PageObject


  # Left bar ~~~~~~~~~~~
  link(:lnkDescription, text: 'Description')
    div(:divDescription, id: 'collapse-description')
  link(:lnkFabricInfo, text: 'Fabric Information')
    div(:divFabric, id: 'collapse-fabric')
  link(:lnkAboutModel, text: 'About our model')
    div(:divAboutModel, id: 'collapse-about')
  link(:lnkAddToMoodboard, text: 'Add to Moodboard')
    div(:divAddToMoodboard, id: 'moodboard-options')
  link(:lnkShare, text: 'Share')
    unordered_list(:lstShareIcons, xpath: "//ul[contains(@class,'share-btn-wrap')]")
    link(:lnkFacebookShare, xpath: "//a[@title='Share to Facebook']")
    link(:lnkTwitterShare, xpath: "//a[@title='Share to Twitter']")
    link(:lnkPinterestShare, xpath: "//a[@title='Share to Pinterest']")

  # Right bar ~~~~~~~~~~
  div(:divSizeFitTab, id: 'tab-size-fit')
  div(:divDressSize, text: 'Dress Size')
  link(:lnkCloseDressSize, xpath: "//*[text()='Choose your size']/..//a[@class='btn-close lg']")
  div(:divSkirtLength, text: 'Height & Hemline')
  link(:lnkCloseHeight, xpath: "//*[text()='Choose your height']/..//a[@class='btn-close lg']")

  div(:divDesignDress, id: 'tab-color-cust')
  div(:divColor, text: 'Color')
  link(:lnkCloseColor, xpath: "//*[contains(text(),'Selected Color')]/..//a[@class='btn-close lg']")
  div(:divCustomize, text: 'Customize')
  link(:lnkCloseCustomize, xpath: "//*[text()='Select your customization']/..//a[@class='btn-close lg']")


  div(:divProductPrice, xpath: "//div[@class='price']")
  link(:lnkAddToBag, text: 'ADD TO BAG')

  # link(:lnkBookNow, link:'/styling-session')
  link(:lnkBookNow,xpath:"//span[@class='cta-link-arrow-right']/..")
  image(:imgAmber,xpath:"//img[contains(@src,'tile-styling-advice')]")
  def expand_description
    unless self.divDescription_element.visible?
      self.lnkDescription_element.when_present.click
    end
  end

  def collapse_description
    if self.divDescription_element.visible?
      self.lnkDescription_element.when_present.click
    end
  end

  def expand_fabric_information
    unless self.divFabric_element.visible?
      self.lnkFabricInfo_element.when_present.click
    end
  end

  def collapse_fabric_information
    if self.divFabric_element.visible?
      self.lnkFabricInfo_element.when_present.click
    end
  end

  def expand_add_to_moodboard
    unless self.divAddToMoodboard_element.visible?
      self.lnkAddToMoodboard_element.when_present.click
    end
  end

  def collapse_add_to_moodboard
    if self.divAddToMoodboard_element.visible?
      self.lnkAddToMoodboard_element.when_present.click
    end
  end

  def expand_about_model
    unless self.divAboutModel_element.visible?
      self.lnkAboutModel_element.when_present.click
    end
  end

  def collapse_about_model
    if self.divAboutModel_element.visible?
      self.lnkAboutModel_element.when_present.click
    end
  end

  def expand_share
    unless self.lstShareIcons_element.visible?
      self.lnkShare_element.when_present.click
    end
  end

  def collapse_share
    if self.lstShareIcons_element.visible?
      self.lnkShare_element.when_present.click
    end
  end

  def open_dress_size
    self.divDressSize_element.when_present(30).click
    self.divSizeFitTab_element.wait_until_present
  end

  def close_dress_size
    self.lnkCloseDressSize_element.when_present.click
    self.divSizeFitTab_element.when_present
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
    self.divSizeFitTab_element.wait_until_present
  end

  def close_skirt_length
    self.lnkCloseHeight_element.when_present.click
    self.divSizeFitTab_element.when_present
  end

  def select_skirt_length(length)
    self.divSkirtLength_element.wait_until_present
    self.link_element(xpath: "//a[text()='#{length}']").when_present(30).click
  end

  def open_color
    self.divColor_element.when_present.click
    self.divDesignDress_element.wait_until_present
  end

  def close_color
    self.lnkCloseColor_element.when_present.click
    self.divDesignDress_element.when_present
  end

  def open_customize
    self.divCustomize_element.when_present.click
    self.divDesignDress_element.wait_until_present
  end

  def close_customize
    self.lnkCloseCustomize_element.when_present.click
    self.divDesignDress_element.when_present
  end

  def add_to_bag
    self.lnkAddToBag_element.when_present(30).click
  end

  def click_book_now
    self.lnkBookNow_element.when_present(30).click
  end

  def click_amber_image
    self.imgAmber_element.when_present(30).click
  end


end