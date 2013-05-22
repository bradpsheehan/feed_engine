# Resque.logger.formatter = Resque::VerboseFormatter.new
# require 'resque_scheduler'

# Resque.schedule = YAML.load_file("#{Rails.root}/config/resque_schedule.yml")

# Resque.redis = RedisConnection.connection
Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }
