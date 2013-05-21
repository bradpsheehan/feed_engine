if Rails.env.development?
  # local development I use a homebrew installed redis installation
  $redis = Redis.new(:host => "localhost", :port => 6379)
else
  # on Heroku, use the url that is preset
  $redis = Redis.connect :url => ENV["OPENREDIS_URL"]
  # you must set the Resque.redis to point to this redis explicitly for some reason
  Resque.redis = $redis
end
