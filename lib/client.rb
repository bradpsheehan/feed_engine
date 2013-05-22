module Client
  module API
    extend self

    def get_runs(user)
      rk_user = Runkeeper::User.new(user.app_token)
      runs = rk_user.fitness_activities_feed.body.to_hash
      Populator.add_activity_list(runs, user)
    end

    def get_run_detail(data)
      user = Runkeeper::User.new(data[:token])
      run_detail = user.fitness_activities(id: data[:id]).body.to_hash
    end
  end
end
