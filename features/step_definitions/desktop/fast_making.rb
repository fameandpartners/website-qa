Then(/^go to Fame admin feature flags\.$/) do
  on(FameAdminPage) do |page|
    page.visit_site_version(country: 'USA', url: '/fame_admin/backend/features')
    on(LoginPage) do |page|
      if page.btnLogin_element.visible?
        page.specify_credentials(CONFIG['spree_admin'],CONFIG['admin_pwd'])
        page.submit_login
      end
    end
  sleep 4
  end
end

And(/^([^"]*) Express Making\.$/) do |fast_making|
  on(FameAdminPage) do |page|
    page.fast_making_flag(fast_making)
    page.expire_cache
  end
end

But(/^check it is available on storefront\.$/) do
  on(HomePage) do |page|
    page.visit_site_version(country: 'USA', url: '')
    # page.click_nav_menu('Shop')
    # expect(on(HomePage).link_element(text: 'Express Making').visible?).to be_truthy
    @browser.scroll.to :bottom
    expect(page.link_element(xpath: "//footer//a[text()='Made in 48 Hours']").visible?).to be_truthy
    page.visit_site_version(country: 'USA', url: '/getitquick')
    sleep 2
  end
end

But(/^check it is unavailable on storefront\.$/) do
  on(HomePage) do |page|
    page.visit_site_version(country: 'USA', url: '')
    # page.click_nav_menu('Shop')
    # expect(on(HomePage).link_element(text: 'Express Making').visible?).to be_falsey
    @browser.scroll.to :bottom
    expect(page.link_element(xpath: "//footer//a[text()='Made in 48 Hours']").visible?).to be_falsey
    page.visit_site_version(country: 'USA', url: '/getitquick')
    sleep 2
  end
end