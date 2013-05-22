if Rails.env.development?
  # local development I use a homebrew installed redis installation
  $redis = Redis.new(:host => "localhost", :port => 6379)
else
  # on Heroku, use the url that is preset
  ENV["REDISTOGO_URL"] ||= "redis://redistogo:f2659d6e672e806f7e8d097f3279a330@viperfish.redistogo.com:9637/"
  $redis = Redis.connect :url => ENV["REDISTOGO_URL"]
  # you must set the Resque.redis to point to this redis explicitly for some reason
  Resque.redis = $redis
end
