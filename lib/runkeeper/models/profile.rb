module Runkeeper
  class Profile
    attr_accessor :body
    def initialize(access_token, path)
      response = API.get(path, Configuration.accept_headers[:profile], access_token)
      self.body = response.body
    end
  end
end

