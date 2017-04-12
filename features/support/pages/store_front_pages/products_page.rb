class ProductsPage < MainBasePage

  link(:lnkClearAll, text: 'Clear All')
  div(:divFilterPanel, id: 'js-CollectionFilterApp')
  div(:divColorFilter, xpath: "//div[@id='js-CollectionFilterApp']//div[text()='Color']")
  div(:divStyleFilter, xpath: "//div[@id='js-CollectionFilterApp']//div[text()='Style']")
    checkbox(:chk, id: 'style-a-line')
    checkbox(:chkBodycon, id: 'style-bodycon')
    checkbox(:chkHalter, id: 'style-halter')
    checkbox(:chkLongSleeve, id: 'style-long-sleeve')
    checkbox(:chkSequin, id: 'style-sequin')
    checkbox(:chkStrapless, id: 'style-strapless')
    checkbox(:chkBackless, id: 'style-backless')
    checkbox(:chkFitAndFlare, id: 'style-fit-and-flare')
    checkbox(:chkLace, id: 'style-lace')
    checkbox(:chkOffShoulder, id: 'style-off-shoulder')
    checkbox(:chkSplit, id: 'style-split')
    checkbox(:chkWrap, id: 'style-wrap')
  div(:divBodyshapeFilter, xpath: "//div[@id='js-CollectionFilterApp']//div[text()='Bodyshape']")
    checkbox(:chkApple, id: 'shape-apple')
    checkbox(:chkColumn, id: 'shape-column')
    checkbox(:chkPear, id: 'shape-pear')
    checkbox(:chkStrawberry, id: 'shape-strawberry')
    checkbox(:chkAthletic, id: 'shape-athletic')
    checkbox(:chkHour_glass, id: 'shape-hour_glass')
    checkbox(:chkPetite, id: 'shape-petite')
  div(:divPriceFilter, xpath: "//div[@id='js-CollectionFilterApp']//div[text()='Price']")
  checkbox(:chkPrice_0_199, id: 'price-0-199')
  checkbox(:chkPrice_200_299, id: 'price-200-299')
  checkbox(:chkPrice_300_399, id: 'price-300-399')












end