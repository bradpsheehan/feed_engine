module Runkeeper
  class FitnessActivities
    attr_accessor :body
    def initialize(access_token, path, params)
      path = path + "/#{params[:id]}"
      params = {}
      response = API.get(path, Configuration.accept_headers[:fitness_activity], access_token, params)
      self.body = response.body
    end
  end
end


