When(/^I open 'Contact Us' page\.$/) do
  on(ContactUsPage).open_contact_us
end

Then(/^there are all requires controls\.$/) do
  on(ContactUsPage) do |page|
    page.wait_until { page.text.include? 'Contact Customer Service' }
    contact_us_ctrls=%w(txtFirstName txtLastName txtEmail sltCountryCode txtPhone sltCanWeHelp)
    expect(contact_us_ctrls.inject([]){|arr, n| arr << page.send("#{n}_element") }).to all(be_visible)

  end
end