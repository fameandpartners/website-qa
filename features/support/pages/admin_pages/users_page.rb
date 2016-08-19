require_relative '../../pages/admin_pages/adm_modules/admin_header'

class UsersPage
  include PageObject
  include AdminHeader

  page_url(CONFIG['base_url']+'/admin/users')

  text_field(:txtUserSearch, id: 'q_email_cont')
  button(:btnSearchUsr, xpath: "//form[@id='spree/user_search']//button[@name='button']")
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  def specify_srch_user(email)
    self.txtUserSearch_element.when_present.set(email)
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
