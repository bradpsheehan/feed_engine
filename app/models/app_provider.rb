class AppProvider < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :user_id, :uid, :access_token

  def self.create_from_omniauth(data)
    binding.pry
    create! do |provider|
      provider.name = data[:auth][:provider].downcase
      provider.uid = data[:auth][:uid]
      provider.access_token = data[:auth][:credentials][:token]
      provider.user = data[:user]
    end
  end

  def app_token
    @token ||= app_provider.access_token
  end

end
