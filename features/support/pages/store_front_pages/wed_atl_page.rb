class WeddingAtelier < MainBasePage

  link(:lnkSignUp, href:'/wedding-atelier/signup')
  link(:lnkSignIn, href:'/wedding-atelier/sign_in')

  # Sign In form ~~~~~~~~~~~~~~~~~~~
  text_field(:txtEmail, id:'spree_user_email')
  text_field(:txtPwd, id:'spree_user_password')
  button(:btnSignIn, value:'Log in')
  link(:btnForgotPwd, href:'/spree_user/password/new')

  # Sign Up form ~~~~~~~~~~~~~~~~~~~
  text_field(:txtFirstName, id:'spree_user_first_name')
  text_field(:txtLastName, id:'spree_user_last_name')
  text_field(:txtUserEmail, id:'spree_user_email')
  text_field(:txtUserPwd, id:'spree_user_password')
  button(:btnProceedSignUp, value:'Next')
  button(:btnNext, value:'next')

  # "Size profile" step ~~~~~~~~~~~~
  span(:spnHeightDress,xpath:"//span[contains(@id,'height-container')]")

  # "Wedding board" step ~~~~~~~~~~~
  text_field(:txtBoardName, id:'weddding_name')
  select_list(:spnWeddingRole, id:'wedding_role')
  text_field(:txtBridesmaidsAmount, id:'wedding_bridesmaids')
  span(:spnDecrease, class:'number-field-button dec')
  span(:spnIncrease, class:'number-field-button inc')
  i(:icnCalendar,xpath:"//i[@class='calendar-icon']")
  list_item(:lstBride,text:'Bride')
  list_item(:lstBridesmaid,text:'Bridesmaid')
  list_item(:lstMaidHonor,text:'Maid of Honor')
  list_item(:lstMotherBride,text:'Mother of Bride')
  element(:thYears,th=:element,xpath:"//div[@class='datepicker-months']//th[@class='datepicker-switch']")
  element(:thMonth,th=:element,xpath:"//div[@class='datepicker-days']//th[@class='datepicker-switch']")
  text_field(:txtWeddingDate,id:'spree_user_events_attributes_0_date')

  # "Invitation" step ~~~~~~~~~~~~~~
  text_field(:txtInviteEmail, id:'email_addresses_')
  link(:btnInviteLater, text:'do this later')
  button(:btnSendInvite, value:'send invite')
  # .scroll_into_view

  # Wedding profile board ~~~~~~~~~~
  link(:tabBridesmaidDresses,text:'Bridesmaid dresses')
  link(:tabBridesmaidDresses,text:'Wedding details')
  link(:tabBridesmaidDresses,text:'Bridal party')
  span(:tabBridesmaidDresses,text:'Bridal Gowns')

  # Account details ~~~~~~~~~~~~~~~~
  link(:tabMyOrders, href:'#my-orders')
  link(:tabAccountDetails, href:'#account-details')
  link(:tabSizeProfile, href:'#size-profile')
  text_field(:txtProfileFirstName, id:'first-name')
  text_field(:txtProfileLastName, id:'last-name')
  text_field(:txtProfileEmailAddress, id:'email-address')
  text_field(:txtProfileDateOfBirth, id:'date-of-birth')
  text_field(:txtProfileCurrentPassword, id:'current-password')
  text_field(:txtProfileNewPassword, id:'new-password')
  text_field(:txtProfileConfirmPassword, id:'confirm-password')
  button(:btnUpdate, text:'Update')

  def open_sing_in_up(country, sign_type)
    case sign_type
      when 'Signup'
        self.visit_site_version(country: country, url: '/wedding-atelier/signup')
      when 'Signin'
        self.visit_site_version(country: country, url: '/wedding-atelier/sign_in')
    end
  end
  def specify_registered_user(browser_name)
    if browser_name == 'chrome'
      self.specify_credentials(CONFIG['chrome_user'],CONFIG['chrome_user_pwd'])
    elsif browser_name == 'firefox'
      self.specify_credentials(CONFIG['firefox_user'],CONFIG['firefox_user_pwd'])
    elsif browser_name == 'internet explorer'
      self.specify_credentials(CONFIG['ie_user'],CONFIG['ie_user_pwd'])
    elsif browser_name == 'safari'
      self.specify_credentials(CONFIG['safari_user'],CONFIG['safari_user_pwd'])
    end
  end
  def specify_credentials(user_email, user_pwd)
    self.txtEmail_element.value = user_email
    self.txtPwd_element.value = user_pwd
  end
  def specify_signin_email(email)
    self.txtEmail_element.value = email
  end
  def specify_signin_pwd(pwd)
    self.txtPwd_element.value = pwd
  end
  def sign_in_wed_atl
    self.btnSignIn_element.when_present(30).click
  end
  def specify_user_first_name(first_name)
    self.txtFirstName_element.value = first_name
  end
  def specify_user_last_name(last_name)
    self.txtLastName_element.value = last_name
  end
  def specify_user_email(email)
    self.txtUserEmail_element.value = email
  end
  def specify_user_pwd(pwd)
    self.txtUserPwd_element.value = pwd
  end
  def proceed_sign_up
    self.btnProceedSignUp_element.when_present(30).click
  end
  def click_next
    self.btnNext_element.when_present(30).click
  end
  def open_height_size
    self.spnHeightDress_element.when_present(30).click
  end
  def select_random_height(dress_height)
    self.list_item_element(xpath:"//li[contains(text(),'#{dress_height}')]").when_present(30).click
  end
  def select_random_dress_size(dress_size)
    self.label_element(xpath:"//label[text()='#{dress_size}']").when_present(30).click
  end

  # Wedding board methods ~~~~~~~~~~~~~~~~~~~~
  def specify_wedding_board_name(board_name)
    self.txtBoardName_element.value = board_name
  end
  def select_wedding_role(wedding_role)
    self.spnWeddingRole_element.select(wedding_role)
  end
  def specify_bridesmaids_amount(amount)
    i = 0
    while i < amount  do
      self.spnIncrease_element.when_present(30).click
      i += 1
    end
  end
  def open_calendar
    self.icnCalendar_element.when_present(30).click
  end
  def open_months
    self.thMonth_element.when_present(30).click
  end
  def select_future_month(month)
    self.span_element(xpath:"//span[text()='#{month}']").when_present(30).click
  end
  def select_day(day)
    self.cell_element(xpath:"//td[@class='day' and text()='#{day}']").when_present(30).click
  end
  def open_years
    self.thYears_element.when_present(30).click
  end
  def select_future_year(year)
    self.span_element(xpath:"//span[text()='#{year}']").when_present(30).click
  end

  # Send invitations methods ~~~~~~~~~~~~~~~~~~~~
  def send_invitation(sts)
    case sts
      when true
        self.btnSendInvite_element.when_present(30).click
      when false
        self.btnInviteLater_element.when_present(30).click
    end
  end

  # Account details page methods ~~~~~~~~~~~~~~~~~
  def specify_first_name(fname)
    self.txtProfileFirstName_element.value = fname
  end
  def specify_last_name(lname)
    self.txtProfileLastName_element.value = lname
  end
  def specify_email_address(email)
    self.txtProfileEmailAddress_element.value = email
  end
  def specify_date_of_birth(date_of_birth)
    self.txtProfileDateOfBirth_element.value = date_of_birth
  end
  def specify_current_password(current_pwd)
    self.txtProfileCurrentPassword_element.value = current_pwd
  end
  def specify_new_password(new_pwd)
    self.txtProfileNewPassword_element.value = new_pwd
  end
  def specify_confirm_password(confirm_pwd)
    self.txtProfileConfirmPassword_element.value = confirm_pwd
  end
  def update_profile
    self.btnUpdate_element.when_present.click
  end
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



end
