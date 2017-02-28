Then(/^footer contains links to:$/) do |table|
  on (HomePage) do |page|
    @browser.scroll.to :bottom
    data = table.raw
    data.each do |rowdata|
      rowdata.each do |footer_link|
        puts footer_link
        expect(page.link_element(xpath: "//footer//a[text()=\"#{footer_link}\"]").visible?).to be_truthy
      end
    end
  end
end
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Scenario: User can subscribe from footer. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When(/^I fill up subscribe form with random email\.$/) do
  @browser.scroll.to :bottom
  first_name = Faker::Name.first_name.downcase.to_sym
  last_name = Faker::Name.last_name.downcase.to_sym
  @subscribe_email = "#{first_name}_#{last_name}@ipsum.com"
  puts "Generated email is: #{@subscribe_email}"
  on(HomePage).specify_subscribe_email(@subscribe_email)
end

Then(/^Click "Subscribe" button\.$/) do
  on(HomePage).subscribe_email
end

And(/^"([^"]*)" footer popup appears\.$/) do |msg|
  on(HomePage).paragraph_element(xpath: "//p[contains(text(),'#{msg}')]").when_present(30)
end

Then(/^it can be closed\.$/) do
  on(HomePage).close_footer_popup
end

And(/^user has been subscribed\.$/) do
  pending
end