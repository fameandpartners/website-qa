
And(/^I fill in form fields with:$/) do |table|
  on(CheckOutPage) do |page|
    data = table.rows_hash
    page.specify_email(email: data['Email'])
    sleep 3
  end
end

And(/^I fill in credit card information:$/) do |table|
  on(CheckOutPage) do |page|
    data = table.rows_hash
    page.fill_in_credit(data)
  end
end


Then(/^I click 'Pay Securely'\.$/) do
  on(CheckOutPage) do |page|
    page.pay_securely
  end
end