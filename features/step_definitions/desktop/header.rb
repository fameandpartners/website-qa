#~~~ Open My profile via "My Account" link.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When(/^I login as user\.$/) do
  on(HomePage).click_my_account
  on(LoginPage) do |page|
    page.specify_registered_user(browser_name)
    page.submit_login
    session_data[browser_name][:is_authorized] = true
      # if page.btnLogin_element.visible?
      #   page.specify_registered_user(browser_name)
      #   page.submit_login
      # end
  end
end
Then (/^I open My profile via My Account link\.$/) do
  on(HomePage).click_my_account
end
And(/^"Account settings" page opened\.$/) do
  on(MyProfilePage) do |page|
    page.tabAccSettings_element.when_present
    expect(page.current_url).to include('/profile')
    expect(page.tabAccSettings_element.visible?).to be_truthy
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ My Account menu. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Then(/^I hover mouse to 'My Account' link\.$/) do
  on(HomePage).hover_my_account
end


And(/^I can open:$/) do |table|
  @browser.scroll.to :bottom
  data = table.raw
  data.each do |rowdata|
    on(HomePage).hover_my_account
    rowdata.each do |menu_link|
      on(MyProfilePage).link_element(xpath: "//a[text()='#{menu_link}']").when_present(30).click
      puts "#{menu_link} menu opened"
    end
  end
end

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ User can logout. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
And(/^I logout\.$/) do
  on(HomePage) do |page|
    page.lnkLogout_element.when_present(30).click
    page.click_my_account
    expect(page.current_url).to include('/sign_in')
  end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~ User can change locale. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When(/^I change to "([^"]*)" locale\.$/) do |locale|
  on(ProductPage).visit_site_version(country: 'Australia', url: '', basic_auth: true)
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
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When(/^I can see navigation home menu with all elements\.$/) do
  on(HomePage) do |page|
    nav_main_menu=%w(divHomeMenu imgLogo divNavMainMenu lnkSearch lnkWishlist lnkShoppingCart)
    expect(nav_main_menu.inject([]){|arr, n| arr << page.send("#{n}_element") }).to all(be_visible)
  end
end

Then(/^I can open and close navigation home submenus:$/) do |table|
  on(HomePage) do |page|
    data = table.rows_hash
    page.click_nav_menu(data['New this week'])
    expect(page.divNewThisWeek_element.present?).to be_truthy
    page.click_nav_menu(data['New this week'])
    expect(page.divNewThisWeek_element.present?).to be_falsey
    page.click_nav_menu(data['SHOP'])
    expect(page.divShop_element.present?).to be_truthy
    page.click_nav_menu(data['SHOP'])
    expect(page.divShop_element.present?).to be_falsey
    page.click_nav_menu(data['FAME WEDDINGS'])
    expect(page.divFameWeddings_element.present?).to be_truthy
    page.click_nav_menu(data['FAME WEDDINGS'])
    expect(page.divFameWeddings_element.present?).to be_falsey
    page.click_nav_menu(data['LOOKBOOKS'])
    expect(page.divLookbooks_element.present?).to be_truthy
    page.click_nav_menu(data['LOOKBOOKS'])
    expect(page.divLookbooks_element.present?).to be_falsey
  end
end


And(/^can open "Blog" page\.$/) do
  on(HomePage) do |page|
    page.open_glog
  end
  @browser.windows.last.use
  on(BlogPage) do |page|
    expect(page.current_url).to include('blog.fameandpartners.com')
  end
end

When(/^I open "Search"\.$/) do
  on(HomePage) do |page|
    page.open_search
  end
end

Then(/^I can specify desired dress for search\.$/) do
  on(HomePage) do |page|
    page.specify_dress_for_search('Kirrily')
    page.txtSearch_element.send_keys :return
  end
end

And(/^the founded dress can be opened\.$/) do
  on(HomePage) do |page|
    page.open_dress('Kirrily')
  end
end


When(/^I slide out shopping bag\.$/) do
  on(HomePage).slideout_shopping_cart
end

Then(/^it contains bag's elements\.$/) do
  on(HomePage) do |page|
    sleep 2
    checkout_ctrls=%w(divBack hYourBag btnCheckout btnContinueToPayment pOrderTotal)
    expect(checkout_ctrls.inject([]){|arr, n| arr << page.send("#{n}_element") }).to all(be_visible)
  end
end

And(/^I can slide in shopping bag\.$/) do
  on(HomePage).slidein_shopping_cart
  sleep 1
end