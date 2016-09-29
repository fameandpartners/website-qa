
And(/^it appears in "([^"]*)" orders admin area\.$/) do |country|
  on(LogoutPage).visit_site_version(country: country, url: '/logout')

  on(LoginPage) do |page|
    page.visit_site_version(country: country, url: '/spree_user/sign_in')

    page.specify_credentials(CONFIG['admin'],CONFIG['admin_pwd'])
    page.submit_login
    # if page.txtEmail_element.visible?
    #   page.specify_credentials(CONFIG['admin'],CONFIG['admin_pwd'])
    #   page.submit_login
    # end
  end

  # visit OrdersPage


  on(OrdersPage) do |page|
    page.visit_site_version(country: country, url: '/admin/orders')
    page.specify_search_order(@complete_order_number)
    page.filter_results
    page.link_element(text: @complete_order_number).when_present.click
    page.h1_element(xpath: "//h1[contains(text(),'#{@complete_order_number}')]").when_present
    admin_sub_total = page.span_element(xpath: "//tr[@id='subtotal-row']//td[@class='total']//span").text.gsub(/[^\d\.]/, '').to_f
    admin_shipping = page.span_element(xpath: "//*[@id='order-charges']//td[@class='total']/span").text.gsub(/[^\d\.]/, '').to_f
    admin_order_total = page.span_element(xpath: "//td[@id='order-total']/span").text.gsub(/[^\d\.]/, '').to_f
    expect(@prices[:sub_total]).to eql(admin_sub_total)
    expect(@prices[:shipping]).to eql(admin_shipping)
    expect(@prices[:order_total]).to eql(admin_order_total)

  end
end