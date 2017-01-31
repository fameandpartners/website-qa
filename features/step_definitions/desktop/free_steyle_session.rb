When(/^I open "Free Styling Session" page\.$/) do
  on(FreeStylingSessionPage) do |page|
    page.visit_site_version(country: 'USA', url: '/styling-session')
  end
end


Then(/^I can book via:$/) do |table|
  on(FreeStylingSessionPage) do |page|
    data = table.hashes
    data.each do |session_data|
      page.specify_full_name(full_name: @user_data['Full Name'])
      page.select_session_type(session_data['session_type'])
      page.specify_contact_email
      if session_data['session_type'] == 'Email'
      elsif session_data['session_type'] == 'Text'
        page.specify_phone(phone_number: @user_data['Phone number'])
      elsif session_data['session_type'] == 'Video Chat'
        page.select_time_zone
        page.select_preferred_time('morning')
      elsif session_data['session_type'] == 'Phone'
        page.specify_phone(phone_number: @user_data['Phone number'])
        page.select_time_zone
        page.select_preferred_time('midday')
      elsif session_data['session_type'] == 'At Home'
        page.specify_phone(phone_number: @user_data['Phone number'])
        page.select_time_zone
        page.select_preferred_time('afternoon')
        page.select_preferred_time('evening')
      end
      page.click_book_me_in
      page.hAllDone_element.when_present(30)
      done_titles=%w(pThanks pAmber)
      expect(done_titles.inject([]){|arr, n| arr << page.send("#{n}_element") }).to all(be_visible)
      steps %{
        When I open "Free Styling Session" page.
      }
    end
  end

end

Then(/^next check logic visibility of elements:$/) do |table|
  # table is a table.hashes.keys # => [:session_type, :Email Address, :Phone number, :Timezone, :Preferred time]
  pending
end