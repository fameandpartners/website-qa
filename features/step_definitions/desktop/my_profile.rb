Given(/^I register a new user\.$/) do
  on(HomePage) do |page|
    page.visit_site_version(country: 'USA', url: '', basic_auth: true)
    page.visit_site_version(country: 'USA', url: '/signup')
  end
  on(SignUpPage) do |page|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    page.specify_first_name(first_name)
    page.specify_last_name(last_name)
    @new_user_email = Faker::Internet.safe_email(first_name+'_'+last_name)
    page.specify_email(@new_user_email)
    pwd = Faker::Internet.password(10, 20, true)
    page.specify_passwords(pwd)
    page.specify_confirm_passwords(pwd)
    page.newsletter(false)
    page.click_create_an_account
    puts <<-EOS
User has been generated with next data:
  First name: #{first_name}
   Last name: #{last_name}
       Email: #{@new_user_email}
    Password: #{pwd}
    EOS
  end
end

When(/^I open "My Details" page\.$/) do
  on(MyProfilePage) do |page|
    page.visit_site_version(country: 'USA', url: '/profile')
  end
end

Then(/^I can modify profile data with random data\.$/) do
  on(MyProfilePage) do |page|
    @first_name = Faker::Name.first_name
    @last_name = Faker::Name.last_name
    page.specify_first_name_profile(@first_name)
    page.specify_last_name_profile(@last_name)

    @new_user_email = Faker::Internet.safe_email(@first_name+'_'+@last_name)
    page.change_user_email(@new_user_email)
    @pwd = Faker::Internet.password(10, 20, true)
    page.my_account_pwd(@pwd)
    page.my_account_confirm_pwd(@pwd)
    page.save_profile_changes
  end
end


And(/^can login with new updated email and password\.$/) do
  on(MyProfilePage) do |page|
    page.visit_site_version(country: 'USA', url: '/logout')
    page.visit_site_version(country: 'USA', url: '/login')
  end
  on(LoginPage) do |page|
    page.specify_email(@new_user_email)
    page.specify_pwd(@pwd)
    page.submit_login
  end
end


And(/^check updated profile data\.$/) do
  on(MyProfilePage) do |page|
    page.visit_site_version(country: 'USA', url: '/profile')
    new_first_name = page.txtFirstName_element.value
    new_last_name = page.txtLastName_element.value
    new_email = page.txtEmail_element.value
    expect(new_first_name).to eql(@first_name)
    expect(new_last_name).to eql(@last_name)
    expect(new_email).to eql(@new_user_email)
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When(/^I am on "My Details" page\.$/) do
  on(HomePage).visit_site_version(country: 'USA', url: '', basic_auth: true)
  on(HomePage).click_my_account
  on(LoginPage) do |page|
    page.specify_registered_user(browser_name)
    page.submit_login
  end
  on(HomePage).visit_site_version(country: 'USA', url: '/profile')
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
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~












# And(/^I login with new email password\.$/) do
#   pending
# end
#
# # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# And(/^names were updated\.$/) do
#
# end
#
# And(/^there is also on "My Orders" (.*) page\.$/) do |country|
#   on(MyProfilePage).visit_site_version(country: country, url: '/user_orders')
#   on(MyProfilePage) do |page|
#     page.tblOrdersTable_element.when_present(30)
#     expect(page.link_element(xpath: "//a[text()='#{@complete_order_number}']").visible?).to be_truthy
#   end
# end
#
# When(/^I registered as a new user\.$/) do
#   on(HomePage).visit_site_version(country: 'USA', url: '/signup', basic_auth: true)
#   on(SignUpPage) do |page|
#     page.specify_first_name('Temp')
#     page.specify_last_name('User')
#     @temp_user_email = "#{SecureRandom.uuid}@lorem.com"
#     page.specify_email(@temp_user_email)
#     page.specify_passwords('1qazxcv')
#     page.specify_confirm_passwords('1qazxcv')
#     page.newsletter(false)
#     page.click_create_an_account
#   end
# end
#
#
# And(/^login with new email\.$/) do
#   on(MyProfilePage) do |page|
#     page.visit_site_version(country: 'USA', url: '/logout')
#     page.visit_site_version(country: 'USA', url: '/login')
#   end
#   on(LoginPage) do |page|
#     page.specify_email(@new_email)
#     page.specify_pwd('1qazxcv')
#     page.submit_login
#   end
#   on(HomePage).visit_site_version(country: 'USA', url: '/profile')
# end
#
# Then(/^I can change my password\.$/) do
#   on(HomePage).visit_site_version(country: 'USA', url: '/profile')
#   on(MyProfilePage) do |page|
#     page.my_account_pwd('2wsxcvb')
#     page.my_account_confirm_pwd('2wsxcvb')
#     page.save_profile_changes
#   end
# end
#
# And(/^can login with new password\.$/) do
#   on(HomePage) do |page|
#     page.visit_site_version(country: 'USA', url: '/logout')
#     page.visit_site_version(country: 'USA', url: '/login')
#   end
#   on(LoginPage) do |page|
#     page.specify_email(@temp_user_email)
#     page.specify_pwd('2wsxcvb')
#     page.submit_login
#     page.visit_site_version(country: 'USA', url: '/profile')
#   end
#   expect(on(MyProfilePage).txtEmail_element.value).to eql(@temp_user_email)
# end