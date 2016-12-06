class MyProfilePage < MainBasePage

  page_url(CONFIG['base_url']+'/profile')

  span(:tabAccSettings, xpath: "//span[contains(text(),'Account')]")
  text_field(:txtFirstName, id: 'profile_first_name')
  text_field(:txtLastName, id: 'profile_last_name')
  text_field(:txtEmail, id: 'profile_last_name')
  text_field(:txtPassword, id: 'profile_last_name')
  text_field(:txtPwdConfirm, id: 'profile_last_name')


  def fillup_profile(data={})
    self.txtFirstName_element.when_present.set(data['First Name'])
    self.txtLastName_element.when_present.set(data['Last Name'])

  end


  def update_profile(data)
    self
  end





end