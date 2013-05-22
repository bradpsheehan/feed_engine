class Activity < ActiveRecord::Base
  serialize :run_detail
  attr_accessible :provider, :activity_type,
                  :activity_id, :duration, :distance,
                  :activity_date, :user, :run_detail,
                  :detail_present, :run_id
  belongs_to :user
  validates_presence_of :duration, :distance, :activity_id, :user_id

end
