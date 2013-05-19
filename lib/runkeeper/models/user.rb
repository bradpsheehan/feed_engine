module Runkeeper
  class User
    attr_accessor :access_token, :body

    def initialize(access_token)
      self.access_token = access_token
      response = API.get("user",
                         Configuration.accept_headers[:user],
                         access_token)
      self.body = response.body
    end

    def profile
      Runkeeper::Profile.new access_token, body["profile"]
    end

    def fitness_activities_feed(params = {})
      Runkeeper::FitnessActivitiesFeed.new access_token, body["fitness_activities"], params
    end

    def fitness_activities(params = {})
      Runkeeper::FitnessActivities.new access_token, body["fitness_activities"], params
    end
  end

