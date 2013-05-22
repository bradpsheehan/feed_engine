class AppProvider < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :user_id, :uid, :access_token
  validates_uniqueness_of :user_id

  def self.create_from_omniauth(data)
    binding.pry
    create! do |provider|
      provider.name = data[:auth][:provider].downcase
      provider.uid = data[:auth][:uid]
      provider.access_token = data[:auth][:credentials][:token]
      provider.user = data[:user]
    end
  end


end
