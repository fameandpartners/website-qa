Then(/^footer contains links to:$/) do |table|
  on (HomePage) do |page|
    @browser.scroll.to :bottom
    data = table.hashes
    data.each do |footer_link|
      puts "Link title is: #{footer_link['link_title']} and link url is: #{footer_link['link_url']}"
      expect(page.link_element(xpath: "//footer//a[text()=\"#{footer_link['link_title']}\" and contains(@href,'#{footer_link['link_url']}')]").visible?).to be_truthy
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

Then(/^footer contains next social networks:$/) do |table|
  data = table.rows_hash
  @browser.scroll.to :bottom
  on(HomePage) do |page|
    expect(page.link_element(xpath:"//a[@class='icon-instagram' and @href='#{data['Instagram']}']").visible?).to be_truthy
    puts "Instagram URL icon presented"
    expect(page.link_element(xpath:"//a[@class='icon-facebook2' and @href='#{data['Facebook']}']").visible?).to be_truthy
    puts "Facebook URL icon presented"
    expect(page.link_element(xpath:"//a[@class='icon-twitter' and @href='#{data['Twitter']}']").visible?).to be_truthy
    puts "Twitter URL icon presented"
    expect(page.link_element(xpath:"//a[@class='icon-pinterest' and @href='#{data['Pinterest']}']").visible?).to be_truthy
    puts "Pinterest URL icon presented"
    expect(page.link_element(xpath:"//a[@class='icon-tumblr' and @href='#{data['Tumblr']}']").visible?).to be_truthy
    puts "Tumblr URL icon presented"
    expect(page.link_element(xpath:"//a[@class='icon-polyvore' and @href='#{data['Polyvore']}']").visible?).to be_truthy
    puts "Polyvore URL icon presented"
  end
end