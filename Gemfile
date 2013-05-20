source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'jquery-rails'
gem 'pg'
gem 'rake', '10.0.3'
gem 'sorcery'
gem 'unicorn'
gem 'haml-rails', '>= 0.3.4'
gem 'faker'
gem 'figaro'
gem 'resque', '~> 1.22.0', :require => 'resque/server'
gem 'redis-store', '~> 1.0.0'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-runkeeper'
gem 'omniauth-mapmyfitness'
gem 'twitter'
gem 'json'
gem 'faraday'
gem 'faraday_middleware'
gem 'mono_logger'
gem 'gon'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'eco'
end

group :development, :test do
  gem 'heroku'
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'pry'
  gem 'unicorn'
  gem 'capybara'
  gem 'bullet'
  gem 'sqlite3'
  gem 'guard-rspec'
  gem 'rb-fsevent', '~> 0.9'
  gem 'simplecov', git: "git://github.com/colszowka/simplecov.git", require: false
  gem 'factory_girl_rails', require: false
end

group :test do
  gem 'cane'
  gem 'reek'
  gem 'jasmine'
  gem 'vcr'
  gem 'webmock'
  gem 'database_cleaner'
  gem 'resque_spec'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end
