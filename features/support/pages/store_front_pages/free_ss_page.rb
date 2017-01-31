class FreeStylingSessionPage < MainBasePage

  page_url(CONFIG['base_url']+'/styling-session')


  form(:frmFormStyleSession,id:'new_forms_style_session')
  text_field(:txtFullName,id:'forms_style_session_full_name')
  select_list(:sltSessionType,id:'forms_style_session_session_type')
  text_field(:txtEmail,id: 'forms_style_session_email')
  text_field(:txtPhoneNumber,id:'forms_style_session_phone')
  select_list(:sltSessionTimezone,id:'forms_style_session_timezone')
  select_list(:sltPreferredTime,id:'forms_style_session_preferred_time')
  button(:btnBookMeIn, value: 'BOOK ME IN')

  h3(:hAllDone,xpath:"//h3[text()='All done!']")
  paragraph(:pThanks,xpath:"//p[text()='Thank you for your booking request.']")
  paragraph(:pAmber,xpath:"//p[text()='Amber will be in touch shortly to confirm your booking date and time.']")

  def specify_full_name(full_name:)
    self.txtFullName_element.value = full_name
  end

  def select_session_type(session_type)
    self.sltSessionType_element.when_present.select(session_type)
  end

  def specify_contact_email
    if browser_name == 'chrome'
      self.txtEmail_element.value = CONFIG['chrome_user']
    elsif browser_name == 'firefox'
      self.txtEmail_element.value = CONFIG['firefox_user']
    elsif browser_name == 'internet explorer'
      self.txtEmail_element.value = CONFIG['ie_user']
    elsif browser_name == 'safari'
      self.txtEmail_element.value = CONFIG['safari_user']
    end
  end

  def select_time_zone
    self.sltSessionTimezone_element.options.sample.click
  end

  def specify_phone(phone_number:)
    self.txtPhoneNumber_element.value = phone_number
  end

  def select_preferred_time(time)
    self.sltPreferredTime_element.select(time)
  end

  def click_book_me_in
    self.btnBookMeIn_element.when_present.click
  end

end