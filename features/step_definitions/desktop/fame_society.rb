When(/^I open "The Fame Society" page\.$/) do
  on(HomePage) do |page|
    page.visit_site_version(country: 'USA', url: '', basic_auth: true)
    page.visit_site_version(country: 'USA', url: '/fame-society-application')
  end
end

Then(/^I open "The Fame Society Application" form\.$/) do
  on(FameSocietyPage).open_fame_society_form
end

And(/^sign up for "Fame Society"\.$/) do
  on(FameSocietyPage) do |page|
    full_name = Faker::Name.name
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.safe_email(first_name+'_'+last_name)
    about = Faker::Lorem.paragraph
    blog_url = Faker::Internet.url('blog.example.com')
    country = Faker::Address.country
    street_adress = Faker::Address.street_address
    postal_code = Faker::Address.postcode
    mailing_address = ("#{full_name}, #{street_adress}, #{postal_code}, #{country}")
    dress_size = MainBasePage::USA_SIZES[rand(MainBasePage::USA_SIZES.length)]

    page.specify_full_name(full_name)
    page.specify_society_email(email)
    page.specify_about_you(about)
    page.specify_blog_url(blog_url)
    page.specify_mailing_address(mailing_address)
    page.specify_social_handles('Some lorem ipsum')
    page.specify_dress_size(dress_size)
    page.submit_fame_society_form
    page.h2_element(text:'Thanks for applying').when_present(30)

    page.click_explore_fame
    sleep 3
  end
end