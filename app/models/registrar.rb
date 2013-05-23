class Registrar

  def self.register(data)
    if uid_exists?(data[:auth])
      if current_user_uid_match?(data)
        true
      else
        false
      end
    else
      create_provider(data)
    end
  end

  private

  def self.uid_exists?(payload)
    uid_list(payload).include?(payload[:uid].to_s)
  end

  def self.current_user_uid_match?(data)
    AppProvider.exists?(:user_id => data[:user].id, :uid => data[:auth][:uid].to_s)
  end

  def self.create_provider(data)
    AppProvider.create_from_omniauth(data)
  end

  def self.uid_list(auth)
    @uids ||= AppProvider.where(name: auth[:provider]).pluck(:uid)
  end
end
