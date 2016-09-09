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

Then(/^I fill in contact info with:$/) do |table|
  on(ContactUsPage) do |page|
    data = table.rows_hash
    page.specify_first_name(fname: data['First Name'])
    page.specify_last_name(lname: data['Last Name'])
    page.specify_email(email: data['Email'])
    page.select_country_code(cnt_code: data['Country code'])
    page.specify_phone_number(phone_number: data['Phone number'])
  end
end


And(/^I select "(.*)" type and select "(.*)" category\.$/) do |help, category|
  on(ContactUsPage) do |page|
    page.select_can_we_help(help)
    page.select_category(category)
  end
end
Then(/^I describe my enquiry\.$/) do
  on(ContactUsPage).type_enquiry('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sed risus quis nisl suscipit porta ullamcorper id neque. Aenean pellentesque dui eu ex aliquet accumsan.')
end

And(/^submit my enquiry\.$/) do
  on(ContactUsPage) do |page|
    page.submit_enquiry
    expect(page.text.include? "Thanks! We won't play hard to get, we'll get back to you ASAP.").to be_truthy
  end
end

