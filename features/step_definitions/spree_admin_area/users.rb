When(/^I create a new "([^"]*)"\.$/) do |role|
  on(UsersPage) do |page|
    page.new_user
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    @email = Faker::Internet.safe_email(first_name+'_'+last_name)
    pwd = Faker::Internet.password(10, 20, true)
    page.specify_user_email(@email)
    page.specify_user_first_name(first_name)
    page.specify_user_last_name(last_name)
    page.specify_user_password(pwd)
    page.specify_user_password_confirmation(pwd)
    page.set_user_role(role)
    page.save_user
  end
end

Then(/^it appears in user's list\.$/) do
  on(UsersPage) do |page|
    page.visit_site_version(country: 'USA', url: '/admin/users')
    page.specify_srch_user(@email)
    page.click_search
    expect(page.link_element(xpath: "//a[text()='#{@email}']").visible?).to be_truthy
  end
end

And(/^new user can be opened\.$/) do
  on(UsersPage) do |page|
    page.link_element(xpath: "//a[text()='#{@email}']").when_present.click
    page.click_edit_user_link
  end
end


Then(/^it can be deleted\.$/) do
  on(UsersPage) do |page|
    page.visit_site_version(country: 'USA', url: '/admin/users')
    page.specify_srch_user(@email)
    page.click_search
    page.delete_user(@email, true)
    page.specify_srch_user(@email)
    page.click_search
    expect(page.link_element(xpath: "//a[text()='#{@email}']").visible?).to be_falsey
  end
end

Then(/^it can be updated with new email and password\.$/) do
  on(UsersPage) do |page|
    page.visit_site_version(country: 'USA', url: '/admin/users')
    page.specify_srch_user(@email)
    page.click_search
    page.edit_user(@email)
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    @updated_email = Faker::Internet.safe_email(first_name+'_'+last_name)
    pwd = Faker::Internet.password(10, 20, true)
    page.specify_user_email(@updated_email)
    page.specify_user_first_name(first_name)
    page.specify_user_last_name(last_name)
    page.specify_user_password(pwd)
    page.specify_user_password_confirmation(pwd)
    page.update_user
  end
end

And(/^I can login with new email and password\.$/) do
  on(UsersPage) do |page|
    page.visit_site_version(country: 'USA', url: '/logout')
    page.visit_site_version(country: 'USA', url: '/login')
  end
  on(LoginPage) do |page|
    page.specify_email(@updated_email)
    page.specify_pwd('new1qazxcv')
    page.submit_login
    page.visit_site_version(country: 'USA', url: '/profile')
  end
  on(MyProfilePage) do |page|
    page.txtEmail_element.when_present
    expect(page.txtEmail_element.value).to be == @updated_email
  end
end

Then(/^it can be blocked\.$/) do
  on(UsersPage) do |page|
    page.visit_site_version(country: 'USA', url: '/admin/users')
    page.specify_srch_user(@email)
    page.click_search
    page.edit_user(@email)
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
    page.specify_email(@updated_email)
    page.specify_pwd('new1qazxcv')
    page.submit_login
    page.visit_site_version(country: 'USA', url: '/profile')
  end
end

And(/^"([^"]*)" message appears with login attempt\.$/) do |msg|
  expect(on(LoginPage).text.include?(msg)).to be_truthy
end