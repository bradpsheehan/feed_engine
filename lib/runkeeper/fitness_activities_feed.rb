module Runkeeper
  class FitnessActivitiesFeed
    attr_accessor :body
    def initialize(access_token, path, params)
      path = path + "?pageSize=50"
      response = API.get(path, Configuration.accept_headers[:fitness_activity_feed], access_token, params)
      self.body = response.body
    end
  end
end


