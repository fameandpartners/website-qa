When(/^I create a new user\.$/) do
  on(UsersPage) do |page|
    page.new_user
    @new_email_admin = "#{SecureRandom.uuid}@lorem.com"
    page.specify_user_email(@new_email_admin)
    page.specify_user_first_name('Lorem')
    page.specify_user_last_name('Ipsum')
    page.specify_user_password('1qazxcv')
    page.specify_user_password_confirmation('1qazxcv')
    page.set_user_role(true)
    page.save_user
  end
end

Then(/^it appears in user's list\.$/) do
  on(UsersPage) do |page|
    page.visit_site_version(country: 'USA', url: '/admin/users')
    page.specify_srch_user(@new_email_admin)
    page.click_search
    expect(page.link_element(xpath: "//a[text()='#{@new_email_admin}']").visible?).to be_truthy
  end
end

And(/^new user can be opened\.$/) do
  on(UsersPage) do |page|
    page.link_element(xpath: "//a[text()='#{@new_email_admin}']").when_present.click
    page.click_edit_user_link
    sleep 2
  end
end