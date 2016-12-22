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

When(/^I fill up subscribe form\.$/) do
  @browser.scroll.to :bottom
  on(HomePage).specify_subscribe_email('test@mail.com')
end

Then(/^Click "Subscribe" button\.$/) do
  on(HomePage).subscribe_email
end

And(/^"([^"]*)" footer popup appears\.$/) do |msg|
  on(HomePage).paragraph_element(xpath: "//p[contains(text(),'#{msg}')]").when_present
end

And(/^it can be closed\.$/) do
  on(HomePage).close_footer_popup
end