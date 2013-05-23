class FetchRunData
  @queue = :fetch_runs

  def self.perform(data, user_id)

    activity_id = Populator.get_activity_id(data["uri"])
    user = User.find(user_id)
    run_detail = Client::API.get_run_detail(token: user.app_token,
                                            id: activity_id)
    activity = data.merge({"run_detail"=> run_detail})
    Populator.create_activity(activity, user)
  end
end

