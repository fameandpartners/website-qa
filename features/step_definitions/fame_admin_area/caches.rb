Then(/^expire cache\.$/) do
  on(FameAdminPage) do |page|
    page.expire_cache
  end
end
