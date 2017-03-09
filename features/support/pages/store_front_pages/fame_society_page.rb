class FameSocietyPage < MainBasePage

  span(:spnAllyNow, text: 'APPLY NOW')
  text_field(:txtFullaName, name:'full_name')
  text_field(:txtEmail, name:'email')
  textarea(:txaAboutYou, name:'about')
  text_field(:txtBlogUrl, name:'blog_url')
  text_field(:txtMailingAddress, name:'mailing_address')

  text_field(:txtSocialHandles, name:'social_handles_0')
  text_field(:txtDressSize, name:'dress_size')
  button(:btnSubmit, text:'SUBMIT')
  span(:spnExploreFame, text:'EXPLORE FAME')

  def open_fame_society_form
    self.spnAllyNow_element.when_present(30).click
  end

  def specify_full_name(full_name)
    self.txtFullaName_element.value = full_name
  end

  def specify_society_email(email)
    self.txtEmail_element.value = email
  end

  def specify_about_you(about)
    self.txaAboutYou_element.value = about
  end

  def specify_blog_url(blog_url)
    self.txtBlogUrl_element.value = blog_url
  end

  def specify_mailing_address(mailing_address)
    self.txtMailingAddress_element.value = mailing_address
  end

  def specify_social_handles(social_handles)
    self.txtSocialHandles_element.value = social_handles
  end

  def specify_dress_size(dress_size)
    self.txtDressSize_element.value = dress_size
  end

  def submit_fame_society_form
    self.btnSubmit_element.when_present(30).click
  end

  def click_explore_fame
    self.spnExploreFame_element.when_present(30).click
  end


end