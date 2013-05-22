module DailyMile
  class Activities

    def for_user(username)
      response = Net::HTTP.get('api.dailymile.com', "/people/#{username}/entries.json")
      activities = JSON.parse(response)
      binding.pry
      activities["entries"]
    end

  end
end
