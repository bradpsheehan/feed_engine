class FitnessApp < ActiveRecord::Base
  belongs_to :user

  attr_accessible :name, :user_id, :username

  validates_presence_of :name, :user_id
  validates :uid, :access_token, :presence => true,
                     :if => lambda { |fitness_app| fitness_app.name == 'runkeeper' }
  validates :username, :presence => true,
                     :if => lambda { |fitness_app| fitness_app.name == 'dailymile' }
  validates_uniqueness_of :user_id

  def self.create_from_omniauth(data)
    create! do |fitness_app|
      fitness_app.name = data[:auth][:provider].downcase
      fitness_app.uid = data[:auth][:uid]
      fitness_app.access_token = data[:auth][:credentials][:token]
      fitness_app.user = data[:user]
    end
  end


end
