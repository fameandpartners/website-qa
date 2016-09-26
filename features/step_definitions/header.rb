#~~~ Open My profile via "My Account" link.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When(/^I login as user\.$/) do
  on(HomePage).click_my_account
  on(LoginPage) do |page|
    if browser_name == 'chrome'
      page.specify_credentials(CONFIG['chrome_user'],CONFIG['chrome_user_pwd'])
    elsif browser_name == 'firefox'
      page.specify_credentials(CONFIG['firefox_user'],CONFIG['firefox_user_pwd'])
    elsif browser_name == 'internet explorer'
      page.specify_credentials(CONFIG['ie_user'],CONFIG['ie_user_pwd'])
    elsif browser_name == 'safari'
      sleep 2
      page.specify_credentials(CONFIG['safari_user'],CONFIG['safari_user_pwd'])
    end
    page.submit_login
    @is_authorized = true
  end
end
Then (/^I open My profile via My Account link\.$/) do
  on(HomePage).click_my_account
end
And(/^Account settings page opened\.$/) do
  on(MyProfilePage) do |page|
    expect(page.current_url).to include('/profile')
    expect(page.tabAccSettings_element.visible?).to be_truthy
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ My Account menu. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Then(/^I hover mouse to 'My Account' link\.$/) do
  on(HomePage).hover_my_account
end
And(/^I can open (.*)\.$/) do |menu_item|
  on(MyProfilePage).link_element(xpath: "//a[text()='#{menu_item}']").when_present.click
end

And(/^url equals to "(.*)"\.$/) do |url|
  expect(on(MyProfilePage).current_url).to include(url)
end


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ User can logout. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
And(/^I logout\.$/) do
  on(HomePage) do |page|
    page.lnkLogout_element.when_present.click
    page.click_my_account
    expect(page.current_url).to include('/spree_user/sign_in')
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ User can change locale. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When(/^I change to "([^"]*)" locale\.$/) do |locale|
  on(HomePage) do |page|
    page.click_locale_menu
    page.select_locale(locale)
  end
end
Then(/^"([^"]*)" locale changed\.$/) do |locale|
  on(HomePage) do |page|
    case locale
      when 'Australia'
        expect(page.current_url).to include('fameandpartners.com.au')
      when 'USA'
        expect(page.current_url).to include('fameandpartners.com')
    end

  end
end
And(/^header message changed to "([^"]*)"\.$/) do |msg|
  pending
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


