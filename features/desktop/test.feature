Feature: test

  Scenario: test
    When I wait for "some" to be added to my basket.
#
#do |product| Watir::Waiter::wait_until do basket = browser.div(:id, 'pnlBasket') basket.span(:text, product).exists? end
#end
#
#<span style="color: #333333; font-family: Effra, Verdana, sans-serif; font-size: 10px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; display: inline !important; float: none; background-color: #f3f2e9;">When /I wait for "([^\"]*)" to be added to my basket/ do |product| Watir::Waiter::wait_until do basket = browser.div(:id, 'pnlBasket') basket.span(:text, product).exists? end end - See more at: http://developer.7digital.com//blog/wait-ajax-callback-watir#sthash.pHIPwSGL.dpuf</span>
