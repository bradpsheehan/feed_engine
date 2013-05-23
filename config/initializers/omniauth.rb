Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'], :client_options => {:authorize_path => '/oauth/authorize'}
  provider :runkeeper, ENV['RUNKEEPER_CLIENT_ID'], ENV['RUNKEEPER_CLIENT_SECRET']
  provider :mapmyfitness, ENV['MAPMYFITNESS_CONSUMER_KEY'], ENV['MAPMYFITNESS_SECRET_KEY']
  # provider :dailymile, ENV['DAILYMILE_KEY'], ENV['DAILYMILE_SECRET']
end

