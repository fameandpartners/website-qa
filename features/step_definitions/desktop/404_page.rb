When(/^I specify non existing URL\.$/) do
  on(HomePage).visit_site_version(country: 'USA', url: '/lorem_ipsum')
end

Then(/^404 page displays to user\.$/) do
  on(FortyFourPage).div_element(xpath:"//*[@id='content-container']").when_present
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