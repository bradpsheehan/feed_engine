class Registrar

  def self.register(data)
    return true if current_user_valid?(data)
    return false if user_fitness_app_mismatch?(data)

    # if uid_exists?(data[:auth])
    #   if current_user_uid_match?(data)
    #     true
    #   else
    #     false
    #   end

    # else
      create_provider(data)
    # end
  end

  private

  def self.current_user_valid?(data)
    uid_exists?(data[:auth]) && current_user_uid_match?(data)
  end

  def self.user_fitness_app_mismatch?(data)
    uid_exists?(data[:auth]) && !current_user_uid_match?(data)
  end

  def self.uid_exists?(payload)
    uid_list(payload).include?(payload[:uid].to_s)
  end

  def self.current_user_uid_match?(data)
    FitnessApp.exists?(:user_id => data[:user], :uid => data[:auth][:uid])
  end

  def self.create_provider(data)
    FitnessApp.create_from_omniauth(data)
  end

  def self.uid_list(auth)
    @uids ||= FitnessApp.where(name: auth[:provider]).pluck(:uid)
  end
end
