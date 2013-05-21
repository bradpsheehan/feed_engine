#!/usr/bin/env rake
require File.expand_path('../config/application', __FILE__)

FeedEngine::Application.load_tasks

namespace :sanitation do
  desc "Check line lengths & whitespace with Cane"
  task :lines do
    puts ""
    puts "== using cane to check line length =="
    system("cane --no-abc --style-glob 'app/**/*.rb' --no-doc")
    puts "== done checking line length =="
    puts ""
  end

  desc "Check method length with Reek"
  task :methods do
    puts ""
    puts "== using reek to check method length =="
    system("reek -n app/**/*.rb 2>&1 | grep -v ' 0 warnings'")
    puts "== done checking method length =="
    puts ""
  end

  desc "Check both line length and method length"
  task :all => [:lines, :methods]
end

# Resque tasks
require 'resque/tasks'
require 'resque_scheduler/tasks'

task "resque:setup" => :environment do
  require 'resque'
  require 'resque_scheduler'
  require 'resque/scheduler'

  # Resque.redis = 'localhost:6379'
  schedule = YAML.load_file("#{Rails.root}/config/resque_schedule.yml")
  # puts schedule
  Resque.schedule = schedule

  # require 'tasks'
end
