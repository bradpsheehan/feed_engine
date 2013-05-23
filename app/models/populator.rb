class Populator
  def self.add_activity_list(data, user)
    user_activities = get_user_activities(user, "runkeeper")

    data["items"].each do |activity|
      activity_id = self.get_activity_id(activity["uri"])
      next if user_activities.include?(activity_id)
      Resque.enqueue(FetchRunData, activity, user.id)
    end
 end


  def self.get_activity_id(uri)
    uri.split("/")[-1]
  end


  def self.create_activity(data, user)
    run = Run.fuzzy_find({user: user,
                          started_at: DateTime.parse(data["start_time"])})
    run_id = run ? run.id : nil
    Activity.create!(activity_type: data["type"],
                     duration: data["duration"],
                     distance: data["total_distance"],
                     activity_date: data["start_time"],
                     activity_id: self.get_activity_id(data["uri"]),
                     provider: data["source"],
                     run_detail: data["run_detail"],
                     detail_present: true,
                     user: user,
                     run_id: run_id)
  end

  def self.add_dm_activities(data, user, provider)
    user_activities = get_user_activities(user, "dailymile")

    data.each do |activity|
      next if user_activities.include?(activity["id"])
      self.create_dm_activities(activity, user, provider)
    end
  end

  def self.create_dm_activities(data, user, provider)
    Activity.create!(activity_type: data["workout"]["activity_type"].downcase,
                     duration: data["workout"]["duration"],
                     distance: data["workout"]["distance"]["value"],
                     activity_date: data["at"],
                     activity_id: data["id"],
                     provider: provider,
                     user: user)
  end


  private

  def self.get_user_activities(user, provider)
    @activities ||= Activity.where(user_id: user, provider: provider).pluck(:activity_id)
  end


end

