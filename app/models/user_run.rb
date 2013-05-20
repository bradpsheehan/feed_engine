class UserRun < ActiveRecord::Base

  belongs_to :user
  belongs_to :run

  attr_accessible :user_id, :status, :run_id

end
