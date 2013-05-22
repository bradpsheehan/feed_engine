module ActivitiesHelper

  def readable_duration(duration_in_seconds)
    duration_in_minutes = duration_in_seconds / 60

    hours = duration_in_minutes / 60
    minutes = duration_in_minutes % 60

    "#{hours.to_i} hour #{minutes.to_i} min "
  end
end
