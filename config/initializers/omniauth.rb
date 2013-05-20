Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "ukOeH0KtECU7dvzvuMx9OA", "0633qRT9loRaJWToCvYtrzh5tfQHHWztUBl9KXqo"
  provider :runkeeper, ENV['RUNKEEPER_CLIENT_ID'], ENV['RUNKEEPER_CLIENT_SECRET']
  provider :mapmyfitness, ENV['MAPMYFITNESS_CONSUMER_KEY'], ENV['MAPMYFITNESS_SECRET_KEY']
end

