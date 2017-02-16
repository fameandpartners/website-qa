
When(/^I open Wedding Atelier "([^"]*)" form\.$/) do |sign_type|
  on(WeddingAtelier) do |page|
    page.open_sing_in_up(sign_type)
  end
end

Then(/^I can specify user credentials\.$/) do
  on(WeddingAtelier).specify_registered_user(browser_name)
end

And(/^sign in\.$/) do
  on(WeddingAtelier) do |page|
    page.sign_in_wed_atl
  end
end

Then(/^fill up signup form with random data\.$/) do
  on(WeddingAtelier) do |page|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.safe_email
    pwd = Faker::Internet.password(10, 20, true)
    page.specify_user_first_name(first_name)
    page.specify_user_last_name(last_name)
    page.specify_user_email(email)
    page.specify_user_pwd(pwd)
    puts <<-EOS
User has been generated with next data:
  First name: #{first_name}
   Last name: #{last_name}
       Email: #{email}
    Password: #{pwd}
EOS

    sleep 3
  end
end

And(/^click NEXT button\.$/) do
  on(WeddingAtelier).click_next
end

Then(/^user can fill up "Size profile" page\.$/) do
  pending
end

And(/^create wedding board\.$/) do
  pending
end

But(/^send invitation later\.$/) do
  pending
end

And(/^wedding board with online chat appear\.$/) do
  on(WeddingAtelier) do |page|
    page.send_invitation(false)
  end
end