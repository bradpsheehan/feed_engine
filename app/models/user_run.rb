class UserRun < ActiveRecord::Base

  attr_accessible :user_id, :status, :run_id
  # def self.create(run_id, user_id, status)
  #   user_run = UserRun.new
  #   user_run.run_id = run_id
  #   user_run.user_id = user_id
  #   user_run.status = status
  #   user_run.save!
  # end

end
