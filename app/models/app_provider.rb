class AppProvider < ActiveRecord::Base
  belongs_to :user

  attr_accessible :name, :user_id, :username

  validates_presence_of :name, :user_id
  validates :uid, :access_token, :presence => true,
                     :if => lambda { |app_provider| app_provider.name == 'runkeeper' }
  validates :username, :presence => true,
                     :if => lambda { |app_provider| app_provider.name == 'dailymile' }
  validates_uniqueness_of :user_id

  def self.create_from_omniauth(data)
    create! do |provider|
      provider.name = data[:auth][:provider].downcase
      provider.uid = data[:auth][:uid]
      provider.access_token = data[:auth][:credentials][:token]
      provider.user = data[:user]
    end
  end


end
