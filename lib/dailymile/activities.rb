module Dailymile
  class Activities

    def for_user(user)
      response = Net::HTTP.get('api.dailymile.com', "/people/#{user.username}/entries.json")
      activities = JSON.parse(response)
      Populator.add_dm_activities(activities["entries"],user,"dailymile")
    end

  end
end
