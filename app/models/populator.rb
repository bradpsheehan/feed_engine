class Populator
  def self.add_activity_list(data, user)
    user_activities = get_user_activities(user)

    # help_needed!

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
    run = Run.fuzzy_find({user: user, started_at: DateTime.parse(data["start_time"])})
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

  private

  def self.get_user_activities(user)
    @activities ||= Activity.where(user_id: user).pluck(:activity_id)
  end


end

