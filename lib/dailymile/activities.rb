module Dailymile
  class Activities

    def for_user(username)
      response = Net::HTTP.get('api.dailymile.com', "/people/#{username}/entries.json")
      activities = JSON.parse(response)
      activities["entries"]
    end

  end
end
