#~~~ Open My profile via "My Account" link.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When(/^I login as user\.$/) do
  on(HomePage).click_my_account
  on(LoginPage) do |page|
    page.specify_credentials(CONFIG['user_email'],CONFIG['user_pwd'])
    page.submit_login
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
#~~~ My Account menu.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Then(/^I hover mouse to 'My Account' link\.$/) do
  on(HomePage) do |page|
    page.hover_my_account
  end
end
And(/^I can open (.*)\.$/) do |menu_item|
  on(MyProfilePage).link_element(xpath: "//a[text()='#{menu_item}']").when_present.click

  sleep 2
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