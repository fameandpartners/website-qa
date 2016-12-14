When(/^I wait for "([^"]*)" to be added to my basket\.$/) do |arg|
  Watir::Waiter::wait_until do
    basket = browser.div(:id, 'pnlBasket')
    basket.span(:text, product).exists?
  end

end