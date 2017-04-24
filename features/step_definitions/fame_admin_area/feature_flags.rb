Then(/^disable next flags:$/) do |table|
  on(FameAdminPage) do |page|
    page.fast_making_flag('disable')
    page.cny_flag('disable')
    page.i_eql_change('disable')
    sleep 4
  end
end