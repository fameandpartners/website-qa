class UsersPage < MainBasePage

  page_url(CONFIG['base_url']+'/admin/users')

  link(:btnNewUser, id: 'admin_new_user_link')
  text_field(:txtUserSearch, id: 'q_email_cont')
  button(:btnSearchUsr, xpath: "//form[@id='spree/user_search']//button[@name='button']")


  # New user form ~~~~~~~~~~~~~~~~~~~~~~~~
  text_field(:txtUserEmailAdmin, id: 'user_email')
  text_field(:txtUserFirstNameAdmin, id: 'user_first_name')
  text_field(:txtUserLastNameAdmin, id: 'user_last_name')
  text_field(:txtUserPwdAdmin, id: 'user_password')
  text_field(:txtUserPwdConfirmAdmin, id: 'user_password_confirmation')
  checkbox(:chkAdminRole, id: 'user_spree_role_admin')
  checkbox(:chkUserRole, id: 'user_spree_role_user')
  button(:btnCreateUser, xpath: "//button[text()='Create']")
  span(:spnEditLink, text: 'Edit')

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  span(:btnCancel, text: 'Cancel')

  def new_user
    self.btnNewUser_element.when_present.click
  end

  def specify_user_email(email)
    self.txtUserEmailAdmin_element.value = email
  end

  def specify_user_first_name(fname)
    self.txtUserFirstNameAdmin_element.value = fname
  end

  def specify_user_last_name(lname)
    self.txtUserLastNameAdmin_element.value = lname
  end

  def specify_user_password(pwd)
    self.txtUserPwdAdmin_element.value = pwd
  end

  def specify_user_password_confirmation(pwd)
    self.txtUserPwdConfirmAdmin_element.value = pwd
  end

  def click_edit_user_link
    self.spnEditLink_element.when_present.click
  end

  def set_user_role(sts)
    self.chkUserRole_element.check
  end

  def save_user
    self.btnCreateUser_element.when_present.click
  end

  def specify_srch_user(email)
    self.txtUserSearch_element.value = email
  end

  def click_search
    self.btnSearchUsr_element.when_present.click
  end

  def delete_user(email,confirm)
    if self.link_element(xpath: "//a[text()='#{email}']").visible?
      self.link_element(xpath: "//a[text()='#{email}']/../..//a[@data-action='remove']").when_present.click
      case confirm
        when true
          @browser.alert.ok
        when false
          @browser.alert.close
      end
    end
  end

end
