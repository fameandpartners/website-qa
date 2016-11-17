
And(/^it appears in "([^"]*)" orders admin area\.$/) do |country|
  on(LogoutPage).visit_site_version(country: country, url: '/logout')

  on(LoginPage) do |page|
    page.visit_site_version(country: country, url: '/spree_user/sign_in')
    page.specify_credentials(CONFIG['admin'],CONFIG['admin_pwd'])
    page.submit_login
  end
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

When(/^I go to created order\.$/) do
  on(LogoutPage).visit_site_version(country: 'USA', url: '/logout')
  on(LoginPage) do |page|
    page.visit_site_version(country: 'USA', url: '/spree_user/sign_in')
    page.specify_credentials(CONFIG['admin'],CONFIG['admin_pwd'])
    page.submit_login
  end
  on(OrdersPage) do |page|
    page.visit_site_version(country: 'USA', url: '/admin/orders')
    page.specify_search_order(@order_number)
    page.filter_results
    page.link_element(text: @order_number).when_present.click
    page.h1_element(xpath: "//h1[contains(text(),'#{@order_number}')]").when_present
    admin_sub_total = page.span_element(xpath: "//tr[@id='subtotal-row']//td[@class='total']//span").text.gsub(/[^\d\.]/, '').to_f
    admin_shipping = page.span_element(xpath: "//*[@id='order-charges']//td[@class='total']/span").text.gsub(/[^\d\.]/, '').to_f
    admin_order_total = page.span_element(xpath: "//td[@id='order-total']/span").text.gsub(/[^\d\.]/, '').to_f
    expect(@prices[:sub_total]).to eql(admin_sub_total)
    expect(@prices[:shipping]).to eql(admin_shipping)
    expect(@prices[:order_total]).to eql(admin_order_total)
  end
end

Then(/^I can add an adjustment for it\.$/) do
  on(OrdersPage) do |page|
    page.open_adjustments
    page.new_adjustment
    adjustment_amount = 25
    page.specify_adjustment_amount(adjustment_amount)
    adjustment_description = 'Test adjustment description'
    page.specify_adjustment_description(adjustment_description)
    page.continue_adjustment
    page.tblAdjustments_element.when_present
    expect(page.cell_element(xpath: "//td[text()='#{adjustment_description}']/../td[text()='$#{adjustment_amount}.00']").visible?).to be_truthy
  end
end

And(/^be sure that it recalculated correctly\.$/) do
  on(OrdersPage) do |page|
    page.open_order_details
    page.tblOrderDetails_element.when_present
    admin_order_total = page.span_element(xpath: "//span[@id='order_total']").text.gsub(/[^\d\.]/, '').to_f
    @new_order_total = @prices[:order_total] + 25
    expect(admin_order_total).to eql(@new_order_total)
  end
end

Then(/^I can remove added adjustment for it\.$/) do
  on(OrdersPage) do |page|
    page.open_adjustments
    page.delete_adjustment(true)
  end
end

And(/^be sure that it recalculated correctly after adjustment removing\.$/) do
  on(OrdersPage) do |page|
    page.open_order_details
    page.tblOrderDetails_element.when_present
    admin_order_total = page.span_element(xpath: "//span[@id='order_total']").text.gsub(/[^\d\.]/, '').to_f
    @new_order_total = @new_order_total - 25
    expect(admin_order_total).to eql(@new_order_total)
  end
end