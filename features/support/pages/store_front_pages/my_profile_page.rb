class MyProfilePage < MainBasePage

  page_url(CONFIG['base_url']+'/profile')

  span(:tabAccSettings, xpath: "//span[contains(text(),'Account')]")
  text_field(:txtFirstName, id: 'profile_first_name')
  text_field(:txtLastName, id: 'profile_last_name')
  text_field(:txtEmail, id: 'profile_email')
  text_field(:txtPassword, id: 'profile_password')
  text_field(:txtPwdConfirm, id: 'profile_password_confirmation')
  button(:btnSaveChanges, value: 'Save changes')


  def specify_first_name_profile(data={})
    self.txtFirstName_element.when_present.set(data['First Name'])
  end

  def specify_last_name_profile(data={})
    self.txtLastName_element.when_present.set(data['Last Name'])
  end

  def update_profile(data)
    self
  end

  def change_user_email(email)
      self.txtEmail_element.value = email
  end

  def my_account_pwd(pwd)
    self.txtPassword_element.value = pwd
  end

  def my_account_confirm_pwd(pwd_confirm)
    self.txtPwdConfirm_element.value = pwd_confirm
  end

  def save_profile_changes
    self.btnSaveChanges_element.when_present.click
  end

end