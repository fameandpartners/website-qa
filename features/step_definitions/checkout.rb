And(/^I fill in form fields with:$/) do |table|
  on(CheckOutPage) do |page|
    data = table.rows_hash
    page.specify_email(email: data['Email'])
    page.specify_first_name(fname: data['First Name'])
    page.specify_last_name(lname: data['Last Name '])
  end
end

And(/^I fill in credit card information\.$/) do |table|
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

And(/^I click on 'Place My Order' button\.$/) do
  on(CheckOutPage).place_my_order
  sleep 3
end

