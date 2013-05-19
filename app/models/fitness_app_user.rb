class FitnessAppUser < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :uid, :provider, :name, :user_id
end
