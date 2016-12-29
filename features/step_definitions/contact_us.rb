#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ User can open 'Contact Us' page. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When(/^I open 'Contact Us' page\.$/) do
  on(ContactUsPage).open_contact_us
end

Then(/^there are all required 'Contact Us' controls\.$/) do
  on(ContactUsPage) do |page|
    page.wait_until { page.text.include? 'Contact Customer Service' }
    contact_us_ctrls=%w(txtFirstName txtLastName txtEmail sltCountryCode txtPhone sltCanWeHelp)
    expect(contact_us_ctrls.inject([]){|arr, n| arr << page.send("#{n}_element") }).to all(be_visible)
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ User can send an enquiry to all help categories. ~~~~~~~~~~~~~~~~~~~~~~~~~~~
Given(/^I have user's data:$/) do |table|
  @user_data = table.rows_hash
end

Then(/^I can send an enquiry to all help categories:$/) do |table|
  on(ContactUsPage) do |page|
    data = table.hashes
    data.each do |contact_us_data|
      page.specify_first_name(fname: @user_data['First Name'])
      page.specify_last_name(lname: @user_data['Last Name'])
      page.specify_email(email: @user_data['Email'])
      page.select_country_code(cnt_code: @user_data['Country code'])
      page.specify_phone_number(phone_number: @user_data['Phone number'])
      page.select_can_we_help(contact_us_data['help'])
      page.select_category(contact_us_data['category'])
      msg = "I'm typing message for category '#{contact_us_data['category']}' to help me with '#{contact_us_data['help']}'"
      puts msg
      on(ContactUsPage).type_enquiry(msg)
      page.submit_enquiry
      page.hThanks_element.when_present
      steps %{
        When I open 'Contact Us' page.
      }
    end
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~