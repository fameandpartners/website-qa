class FameAdminPage < MainBasePage

  page_url(CONFIG['base_url']+'/fame_admin/')


  # Caches
  text_field(:txtExpire, id: 'really_expire')
  button(:btnExpire, text: 'EXPIRE ALL')
  # Feature flags
  link(:lnkFeatureFlags,link: '/fame_admin/backend/features')
  link(:lnkFastMaking,xpath: "//a[contains(@href,'feature=getitquick_unavailable')]")
  link(:lnkCNY_flag,xpath:"//a[contains(@href,'feature=cny_delivery_delays')]")
  link(:lnkIeqlChange_flag,xpath:"//a[contains(@href,'feature=i_equal_change')]")
  div(:divExpiredCacheMsg,xpath:"//div[text()='Expired whole cache']")

  def fast_making_flag(sts)
    case sts
      when 'enable'
        if self.lnkFastMaking_element.text == 'Disable'
          self.lnkFastMaking_element.when_present.click
        end
      when 'disable'
        if self.lnkFastMaking_element.text == 'Enable'
          self.lnkFastMaking_element.when_present.click
        end
    end
  end

  def cny_flag(sts)
    self.lnkCNY_flag_element.when_present(30)
    case sts
      when 'enable'
        if self.lnkCNY_flag_element.text == 'Enable'
          self.lnkCNY_flag_element.when_present.click
        end
      when 'disable'
        if self.lnkCNY_flag_element.text == 'Disable'
          self.lnkCNY_flag_element.when_present.click
        end
    end
  end

  def i_eql_change(sts)
    self.lnkCNY_flag_element.when_present(30)
    case sts
      when 'enable'
        if self.lnkIeqlChange_flag_element.text == 'Enable'
          self.lnkIeqlChange_flag_element.when_present.click
          self.expire_cache
        end
      when 'disable'
        if self.lnkIeqlChange_flag_element.text == 'Disable'
          self.lnkIeqlChange_flag_element.when_present.click
        end
    end
  end

  def expire_cache
    self.visit_site_version(country: 'USA', url: '/fame_admin/backend/caches')
    self.txtExpire_element.value = 'EXPIRE'
    self.btnExpire_element.when_present.click
    self.div_element(xpath:"//div[text()='Expired whole cache']").when_present
  end

end