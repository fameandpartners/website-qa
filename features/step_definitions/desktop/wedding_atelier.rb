When(/^I open "([^"]*)" Wedding Atelier "([^"]*)" form\.$/) do |country, sign_type|
  on(HomePage).visit_site_version(country: country, url: '', basic_auth: true)
  on(WeddingAtelier).open_sing_in_up(country,sign_type)
end

Then(/^I can specify user credentials\.$/) do
  on(WeddingAtelier).specify_registered_user(browser_name)
end

And(/^sign in\.$/) do
  on(WeddingAtelier) do |page|
    page.sign_in_wed_atl
  end
end
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Scenario Outline: As anonymous user I can register. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Then(/^fill up signup form with random data\.$/) do
  on(WeddingAtelier) do |page|
    first_name = Faker::Name.first_name
    @fname_for_board = first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.safe_email(first_name+'_'+last_name)
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
  end
end

And(/^click NEXT button\.$/) do
  on(WeddingAtelier).proceed_sign_up
end

Then(/^user can fill up (.*) "Size profile" page and go next\.$/) do |country|
  on(WeddingAtelier) do |page|
    dress_height = MainBasePage::HEIGHT[rand(MainBasePage::HEIGHT.length)]
    puts "Random height is: #{dress_height}"
    page.open_height_size
    page.select_random_height(dress_height)
    puts "Selected height is: #{dress_height}"
    case country
      when 'USA'
        dress_size = MainBasePage::USA_SIZES[rand(MainBasePage::USA_SIZES.length)]
        puts "Random #{country} dress size is: #{dress_size}"
      when 'Australia'
        dress_size = MainBasePage::AUS_SIZES[rand(MainBasePage::AUS_SIZES.length)]
        puts "Random #{country}n dress size is: #{dress_size}"
    end
    page.select_random_dress_size(dress_size)
    puts "Selected dress size is: #{dress_size}"
    page.click_next
  end
end

Then(/^create wedding board\.$/) do
  on(WeddingAtelier) do |page|
    extend WeddingAtelierHelper

    page.specify_wedding_board_name("#{@fname_for_board}'s wedding board")
    page.open_wedding_role
    page.select_wedding_role('Bride')
    page.specify_bridesmaids_amount(2)
    page.open_calendar
    page.open_months
    page.open_years

    wed_date = get_wed_date_hash

    @wed_countdown = wed_date[:countdown]

    puts "Wedding date is: #{wed_date[:full_date]}"
    puts "#{@wed_countdown} days left to wedding."

    page.select_future_year(wed_date[:year])
    page.select_future_month(wed_date[:month])
    page.select_day(wed_date[:day])
    page.click_next
  end
end

But(/^send invitation later\.$/) do
  on(WeddingAtelier) do |page|
    page.send_invitation(false)
  end
end

And(/^wedding board with countdown appears\.$/) do
  on(WeddingAtelier) do |page|
    page.h1_element(xpath:"//h1[@class='moodboard-title text-center']").when_present
    countdown_title = page.h1_element(xpath:"//h1[@class='moodboard-title text-center']").text
    expect(countdown_title).to eql("The Countdown: #{@wed_countdown} days")
  end
end
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Scenario: As user I can update account details. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When(/^I open my wedding account\.$/) do
  on(HomePage).visit_site_version(country: 'USA', url: '', basic_auth: true)
  on(WeddingAtelier) do |page|
    extend WeddingAtelierHelper
    page.open_sing_in_up('USA','Signup')
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.safe_email(first_name+'_'+last_name)
    @pwd = Faker::Internet.password(10, 20, true)
    page.specify_user_first_name(first_name)
    page.specify_user_last_name(last_name)
    page.specify_user_email(email)
    page.specify_user_pwd(@pwd)
    puts <<-EOS
User has been generated with next data:
  First name: #{first_name}
   Last name: #{last_name}
       Email: #{email}
    Password: #{@pwd}
    EOS
    page.proceed_sign_up
    dress_height = MainBasePage::HEIGHT[rand(MainBasePage::HEIGHT.length)]
    page.open_height_size
    page.select_random_height(dress_height)
    puts "Selected height is: #{dress_height}"
    dress_size = MainBasePage::USA_SIZES[rand(MainBasePage::USA_SIZES.length)]
    page.select_random_dress_size(dress_size)
    puts "Selected dress size is: #{dress_size}"
    page.click_next

    page.specify_wedding_board_name("#{first_name}'s wedding board")
    page.open_wedding_role
    page.select_wedding_role('Bride')
    page.open_calendar
    page.open_months
    page.open_years

    wed_date = get_wed_date_hash
    page.select_future_year(wed_date[:year])
    page.select_future_month(wed_date[:month])
    page.select_day(wed_date[:day])
    page.click_next
    page.visit_site_version(country: 'USA', url: '/wedding-atelier/my-account')
  end
end

Then(/^I can update:$/) do |table|
  on(WeddingAtelier) do |page|
    @new_first_name = Faker::Name.first_name
    @new_last_name = Faker::Name.last_name
    @new_email = Faker::Internet.safe_email(@new_first_name+'_'+@new_last_name)
    @new_pwd = Faker::Internet.password(10, 20, true)
    page.specify_first_name(@new_first_name)
    page.specify_last_name(@new_last_name)
    page.specify_email_address(@new_email)
    # page.specify_date_of_birth(date_of_birth)
    page.specify_current_password(@pwd)
    page.specify_new_password(@new_pwd)
    page.specify_confirm_password(@new_pwd)
    page.update_profile
    puts <<-EOS
User data has been updated to:
  First name: #{@new_first_name}
   Last name: #{@new_last_name}
       Email: #{@new_email}
    Password: #{@new_pwd}
      EOS
    page.visit_site_version(country: 'USA', url: '/logout')
  end
end

And(/^specified data were updated\.$/) do
  on(WeddingAtelier) do |page|
    page.open_sing_in_up('USA','Signin')
    page.specify_signin_email(@new_email)
    page.specify_signin_pwd(@new_pwd)
    page.sign_in_wed_atl
    page.visit_site_version(country: 'USA', url: '/wedding-atelier/my-account')
    page.tabAccountDetails_element.when_present(30)
    expect(page.txtProfileFirstName_element.value).to eql(@new_first_name)
    expect(page.txtProfileLastName_element.value).to eql(@new_last_name)
    expect(page.txtProfileEmailAddress_element.value).to eql(@new_email)
  end
end


When(/^I open my wedding size profile\.$/) do
  on(HomePage).visit_site_version(country: 'USA', url: '', basic_auth: true)
  on(WeddingAtelier) do |page|
    page.open_sing_in_up('USA','Signin')
    page.specify_registered_user(browser_name)
  end
end

Then(/^I can change size profile parameters\.$/) do
  sleep 3
end