class UserRun < ActiveRecord::Base
  attr_accessible :user_id, :status, :run_id
  belongs_to :user
  belongs_to :run

end
