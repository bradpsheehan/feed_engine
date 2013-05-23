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

  def meters_to_miles(distance)
    miles = (distance.to_f / 1600).round(2)
    "#{miles.to_s} miles"
  end
end
