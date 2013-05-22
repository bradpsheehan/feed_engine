module DailyMile
  class Activities

    def ""

    end

    def for_user(username)
      response = Net::HTTP.get('api.dailymile.com', "/people/#{username}/entries.json")
      activities = JSON.parse(response)
      activities["entries"]
    end

  end
end
