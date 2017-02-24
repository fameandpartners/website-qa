module WeddingAtelierHelper

  def get_wed_date_hash
    wed_year = Date.today.next_year.strftime('%Y')

    wed_month_name = Date.today.next_month(3).strftime('%b')
    wed_month_num  = Date.today.next_month(3).strftime('%m')

    max_day = Date.new(Date.today.year, Date.today.month, -1).day
    wed_day = Random.new.rand(1..max_day)

    wedding_date = "#{wed_day}/#{wed_month_num}/#{wed_year}"
    current_date = Date.today.strftime('%d/%m/%Y')

    wed_countdown = (Date.parse(wedding_date) - Date.parse(current_date)).to_i

    {
      year:      wed_year,
      month:     wed_month_name,
      day:       wed_day,
      full_date: wedding_date,
      countdown: wed_countdown
    }
  end

end