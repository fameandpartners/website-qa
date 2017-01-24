When(/^I create a new "([^"]*)"\.$/) do |role|
  on(UsersPage) do |page|
    page.new_user
    @new_email_admin = "#{SecureRandom.uuid}@lorem.com"
    page.specify_user_email(@new_email_admin)
    page.specify_user_first_name('Lorem')
    page.specify_user_last_name('Ipsum')
    page.specify_user_password('1qazxcv')
    page.specify_user_password_confirmation('1qazxcv')
    page.set_user_role(role)
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
  end
end


Then(/^it can be deleted\.$/) do
  on(UsersPage) do |page|
    page.visit_site_version(country: 'USA', url: '/admin/users')
    page.specify_srch_user(@new_email_admin)
    page.click_search
    page.delete_user(@new_email_admin, true)
    page.specify_srch_user(@new_email_admin)
    page.click_search
    expect(page.link_element(xpath: "//a[text()='#{@new_email_admin}']").visible?).to be_falsey
  end
end

Then(/^it can be updated with new email and password\.$/) do
  on(UsersPage) do |page|
    page.visit_site_version(country: 'USA', url: '/admin/users')
    page.specify_srch_user(@new_email_admin)
    page.click_search
    page.edit_user(@new_email_admin)
    @updated_user_email = "#{SecureRandom.uuid}@lorem.com"
    page.specify_user_email(@updated_user_email)
    page.specify_user_first_name('Lorem')
    page.specify_user_last_name('Ipsum')
    page.specify_user_password('new1qazxcv')
    page.specify_user_password_confirmation('new1qazxcv')
    page.update_user
  end
end

And(/^I can login with new email and password\.$/) do
  on(UsersPage) do |page|
    page.visit_site_version(country: 'USA', url: '/logout')
    page.visit_site_version(country: 'USA', url: '/login')
  end
  on(LoginPage) do |page|
    page.specify_email(@updated_user_email)
    page.specify_pwd('new1qazxcv')
    page.submit_login
    page.visit_site_version(country: 'USA', url: '/profile')
  end
  on(MyProfilePage) do |page|
    page.txtEmail_element.when_present
    expect(page.txtEmail_element.value).to be == @updated_user_email
  end
end

Then(/^it can be blocked\.$/) do
  on(UsersPage) do |page|
    page.visit_site_version(country: 'USA', url: '/admin/users')
    page.specify_srch_user(@new_email_admin)
    page.click_search
    page.edit_user(@new_email_admin)
    page.unset_user_role('user')
    page.update_user
  end
end

And(/^I can not login with it\.$/) do
  on(UsersPage) do |page|
    page.visit_site_version(country: 'USA', url: '/logout')
    page.visit_site_version(country: 'USA', url: '/login')
  end
  on(LoginPage) do |page|
    page.specify_email(@updated_user_email)
    page.specify_pwd('new1qazxcv')
    page.submit_login
    page.visit_site_version(country: 'USA', url: '/profile')
  end
end

And(/^"([^"]*)" message appears with login attempt\.$/) do |msg|
  expect(on(LoginPage).text.include?(msg)).to be_truthy
end