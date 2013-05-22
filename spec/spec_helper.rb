ENV["RAILS_ENV"] ||= 'test'
require 'simplecov'
SimpleCov.start do
  add_filter '/spec'
  add_group 'apis', 'lib/runkeeper'
end
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'vcr'
require 'database_cleaner'
require 'factory_girl_rails'


VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  # c.allow_playback_repeats = all
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir["lib/**/*.rb"].each {|file| load(file); }

RSpec.configure do |config|

  config.order = "random"
  config.include(OmniauthMacros)
  config.include FactoryGirl::Syntax::Methods

  REDIS_PID = "#{Rails.root}/tmp/pids/redis-test.pid"
  REDIS_CACHE_PATH = "#{Rails.root}/tmp/cache/"


  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    redis_options = {
      "daemonize"     => 'yes',
      "pidfile"       => REDIS_PID,
      "port"          => 9736,
      "timeout"       => 300,
      "save 900"      => 1,
      "save 300"      => 1,
      "save 60"       => 10000,
      "dbfilename"    => "dump.rdb",
      "dir"           => REDIS_CACHE_PATH,
      "loglevel"      => "debug",
      "logfile"       => "stdout",
      "databases"     => 16
    }.map { |k, v| "#{k} #{v}" }.join("\n")
    `echo '#{redis_options}' | redis-server -`
  end

  config.after(:suite) do
    %x{
      cat #{REDIS_PID} | xargs kill -QUIT
      rm -f #{REDIS_CACHE_PATH}dump.rdb
    }
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

OmniAuth.config.test_mode = true

shared_context "standard test dataset" do
  let :current_user do
    current_user = User.new()
    current_user.provider = "twitter"
    current_user.uid = "1428947773"
    current_user.name = "runline4"
    current_user.oauth_token = "1428947773-TgBfPRRdcT9XPBnXcJuoE2nVUydfI7y6WonhyGu"
    current_user.oauth_secret = "lXNUrIkC45eOG3l6aSHDaRKKHNc3PqHPisMF55pYI"
    current_user.save!
    current_user
  end

  let :runline3 do
    runline3 = User.new()
    runline3.provider = "twitter"
    runline3.uid = "1426604066"
    runline3.name = "RunLine3"
    runline3.oauth_token = "1426604066-fJtyEG3BaDTP3PrD3v7tACxXVwaFKnOj40mn3EB"
    runline3.oauth_secret = "07yRkLIBSFRi6IoOysWQzRmlwcsZLGjgRKH5CwrfKw"
    runline3.save!
    runline3
  end

  let :attributes do
    {
      name: "Run Name",
      started_at: Time.now,
      details: "run run run",
      route_id: 1,
      organizer_id: current_user.id
    }
  end
end
