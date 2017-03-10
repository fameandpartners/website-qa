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
      elsif session_data['session_type'] == 'Video Chat'
        page.select_time_zone
        page.select_preferred_time('morning')
      elsif session_data['session_type'] == 'Phone'
        page.specify_phone(phone_number: @user_data['Phone number'])
        page.select_time_zone
        page.select_preferred_time('midday')
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
  on(FreeStylingSessionPage) do |page|
    data = table.hashes
    data.each do |session_data|
      page.select_session_type(session_data['session_type'])
      if session_data['session_type'] == 'Email'
        visible_form_elements=%w(txtFullName sltSessionType txtEmail)
        expect(visible_form_elements.inject([]){|arr, n| arr << page.send("#{n}_element") }).to all(be_visible)
        expect(page.txtPhoneNumber_element.visible?).to be_falsey
        expect(page.sltSessionTimezone_element.visible?).to be_falsey
        expect(page.sltPreferredTime_element.visible?).to be_falsey
      elsif session_data['session_type'] == 'Video Chat'
        visible_form_elements=%w(txtFullName sltSessionType txtEmail sltSessionTimezone sltPreferredTime)
        expect(visible_form_elements.inject([]){|arr, n| arr << page.send("#{n}_element") }).to all(be_visible)
        expect(page.txtPhoneNumber_element.visible?).to be_falsey
      elsif session_data['session_type'] == 'Phone'
        visible_form_elements=%w(txtFullName sltSessionType txtEmail txtPhoneNumber sltSessionTimezone sltPreferredTime)
        expect(visible_form_elements.inject([]){|arr, n| arr << page.send("#{n}_element") }).to all(be_visible)
      end
    end
  end
end