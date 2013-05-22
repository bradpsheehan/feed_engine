module ApplicationHelper

  def date_tag(date)
    if date
      time_tag date, format: '%B %d, %Y'
    else
      "Unknown"
    end
  end
  def better_time_tag(time)
    if time
      time_tag time, format: '%I:%M %p'
    else
      "Unknown"
    end
  end
end
