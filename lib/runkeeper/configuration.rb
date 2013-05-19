module Runkeeper
  module Configuration

    def self.accept_headers
      {   :user => "application/vnd.com.runkeeper.User+json",
          :fitness_activity_feed => "application/vnd.com.runkeeper.FitnessActivityFeed+json",
          :fitness_activity => "application/vnd.com.runkeeper.FitnessActivity+json",
          :strength_training_activity_feed => "application/vnd.com.runkeeper.StrengthTrainingActivityFeed+json",
          :strength_training_activity => "application/vnd.com.runkeeper.StrengthTrainingActivity+json",
          :background_activity_feed => "application/vnd.com.runkeeper.BackgroundActivityFeed+json",
          :background_activity => "application/vnd.com.runkeeper.BackgroundActivity+json",
          :profile => "application/vnd.com.runkeeper.Profile+json",
          :settings => "application/vnd.com.runkeeper.Settings+json"
      }.freeze
    end
  end
end

