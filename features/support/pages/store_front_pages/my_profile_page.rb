class MyProfilePage < MainBasePage

  page_url(CONFIG['base_url']+'/profile')

  table(:tblOrdersTable, xpath: "//table[contains(@class,'orders-table')]")

  span(:tabAccSettings, xpath: "//span[text()='Account Settings']")
  text_field(:txtFirstName, id: 'profile_first_name')
  text_field(:txtLastName, id: 'profile_last_name')
  text_field(:txtEmail, id: 'profile_email')
  text_field(:txtPassword, id: 'profile_password')
  text_field(:txtPwdConfirm, id: 'profile_password_confirmation')
  button(:btnSaveChanges, value: 'Save changes')


  def specify_first_name_profile(f_name)
    self.txtFirstName_element.value = f_name
  end

  def specify_last_name_profile(l_name)
    self.txtLastName_element.value = l_name
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