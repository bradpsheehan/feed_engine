source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'jquery-rails'
gem 'pg'
gem 'rake', '10.0.3'
gem 'sorcery'
gem 'unicorn'
gem 'haml-rails', '>= 0.3.4'
gem 'faker'
gem 'resque', :require => 'resque/server'
gem 'figaro'
gem 'redis-store', '~> 1.0.0'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-runkeeper'
gem 'twitter'
gem 'json'
gem 'faraday'
gem 'faraday_middleware'
gem 'mono_logger'
gem 'gon'
gem 'chronic'

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
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end
