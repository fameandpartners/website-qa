class HomePage < MainBasePage


  page_url(CONFIG['base_url'])

  button(:btnDecline, name: '4_name')


  def accept_offer(offet_sts)
    case offet_sts
      when true
      when false
        self.btnDecline_element.when_present.click
    end
  end



end