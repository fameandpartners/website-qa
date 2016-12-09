class OrderPage < MainBasePage

  page_url(CONFIG['base_url']+'/orders/')


  def puts_url
    puts page_url_value
  end

end


