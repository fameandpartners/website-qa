When(/^I specify non existing (.*) URL\.$/) do |country|
  on(HomePage) do |page|
    @response_code = page.visit_site_version(country: country, basic_auth: true, url: '/lorem_ipsum', response_code: true)
  end
end

Then(/^404 page displays to user\.$/) do
  on(FortyFourPage) do |page|
    page.div_element(xpath:"//*[@id='content-container']").when_present
    puts "I'm expecting for 404 response code"
    expect(@response_code.to_i).to eql(404)
    puts "Response code is really: #{@response_code}"
  end
end

And(/^it has:$/) do |table|
  on(FortyFourPage) do |page|
    data = table.rows_hash
    expect(page.hQuestionTitle_element.present?).to be_truthy
    exist_msg = page.hSorryTitle_element.text
    expect(exist_msg).to eql(data['Message'])

    try_msg = page.prgTryPrg_element.text
    expect(try_msg).to eql(data['Text'])
    expect(page.lnkHomePage_element.present?).to be_truthy

    cont_msg = page.prgEmailUsPrg_element.text
    expect(cont_msg).to eql(data['Contact message'])
    expect(page.lnkEmailUs_element.present?).to be_truthy

  end
end
