When(/^I am on "My Details" page\.$/) do
  visit HomePage
  on(HomePage).click_my_account
  on(LoginPage) do |page|
    page.specify_registered_user(browser_name)
    page.submit_login
  end
  on(HomePage).visit_site_version(country: 'USA', url: '/profile')
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ . ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Then(/^I can modify First and Last names with:$/) do |table|
  on(MyProfilePage) do |page|
    data = table.rows_hash
    page.update_profile(data)
  end
sleep 3

end

And(/^names were updated\.$/) do
  pending
end

And(/^there is also on "My Orders" (.*) page\.$/) do |country|
  on(MyProfilePage).visit_site_version(country: country, url: '/user_orders')
  #
  # if country == 'Australia'
  #   @browser.goto(CONFIG['base_url_au']+'/user_orders')
  # else
  #   visit UserOrdersPage
  # end

  on(UserOrdersPage) do |page|
    page.tblOrdersTable_element.when_present
    expect(page.link_element(xpath: "//a[text()='#{@complete_order_number}']").visible?).to be_truthy
  end
end




When(/^I registered as a new user\.$/) do
  on(HomePage).visit_site_version(country: 'USA', url: '/signup')
  on(SignUpPage) do |page|
    page.specify_first_name('Temp')
    page.specify_last_name('User')
    @temp_user_email = "#{SecureRandom.uuid}@lorem.com"
    page.specify_email(@temp_user_email)
    page.specify_passwords('1qazxcv')
    page.specify_confirm_passwords('1qazxcv')
    page.newsletter(false)
    page.click_create_an_account
  end
end
Then(/^I can change my email\.$/) do
  on(HomePage).visit_site_version(country: 'USA', url: '/profile')
  on(MyProfilePage) do |page|
    @new_email = "#{SecureRandom.uuid}@lorem.com"
    page.change_user_email(@new_email)
    page.my_account_pwd('1qazxcv')
    page.my_account_confirm_pwd('1qazxcv')
    page.save_profile_changes
  end
end

And(/^login with new email\.$/) do
  on(MyProfilePage) do |page|
    page.visit_site_version(country: 'USA', url: '/logout')
    page.visit_site_version(country: 'USA', url: '/login')
  end
  on(LoginPage) do |page|
    page.specify_email(@new_email)
    page.specify_pwd('1qazxcv')
    page.submit_login
  end
  on(HomePage).visit_site_version(country: 'USA', url: '/profile')
end

Then(/^I can change my password\.$/) do
  on(HomePage).visit_site_version(country: 'USA', url: '/profile')
  on(MyProfilePage) do |page|
    page.my_account_pwd('2wsxcvb')
    page.my_account_confirm_pwd('2wsxcvb')
    page.save_profile_changes
  end
end

And(/^can login with new password\.$/) do
  on(HomePage) do |page|
    page.visit_site_version(country: 'USA', url: '/logout')
    page.visit_site_version(country: 'USA', url: '/login')
  end
  on(LoginPage) do |page|
    page.specify_email(@temp_user_email)
    page.specify_pwd('2wsxcvb')
    page.submit_login
    page.visit_site_version(country: 'USA', url: '/profile')
  end
  expect(on(MyProfilePage).txtEmail_element.value).to eql(@temp_user_email)
end

Then(/^I clear my profile fields\.$/) do
  on(MyProfilePage) do |page|
    page.specify_first_name_profile('')
    page.specify_last_name_profile('')
    page.change_user_email('')
  end
end

And(/^try to save profile changes\.$/) do
  on(MyProfilePage).save_profile_changes
end


But(/^"([^"]*)" appears for:$/) do |msg, table|
  on(MyProfilePage) do |page|
    data = table.raw
    data.each do |rowdata|
      rowdata.each do |field_label|
        expect(page.span_element(xpath: "//label[text()='#{field_label}']/../..//span[contains(text(),\"#{msg}\")]").visible?).to be_truthy
      end
    end
  end
end

