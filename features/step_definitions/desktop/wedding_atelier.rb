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
    page.specify_wedding_board_name("#{@fname_for_board}'s wedding board")
    page.open_wedding_role
    page.select_wedding_role('Bride')
    page.specify_bridesmaids_amount(2)
    page.open_calendar
    page.open_months
    page.open_years
    # select next year
    wed_year=Date.today.next_year.strftime('%Y')
    page.select_future_year(wed_year)

    # select 3rd month from current
    wed_month_name=Date.today.next_month(3).strftime('%b')
    wed_month_num=Date.today.next_month(3).strftime('%m')
    page.select_future_month(wed_month_name)
    max_day = Date.new(Date.today.year, Date.today.month, -1).day
    wed_day = Random.new.rand(1..max_day)
    page.select_day(wed_day)
    sleep 3
    wedding_date="#{wed_month_num}/#{wed_day}/#{wed_year}"
    puts "Wedding date is: #{wedding_date}"


    current_date=Date.today.strftime('%d/%m/%Y')
    date = Date.strptime(wedding_date, '%m/%d/%Y')
    formatted_date = date.strftime('%d/%m/%Y')
    a_date = Date.parse(formatted_date)
    b_date = Date.parse(current_date)
    @wed_countdown=(a_date-b_date).to_i
    puts "#{@wed_countdown} days left to wedding."
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


