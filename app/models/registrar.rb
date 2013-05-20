class Registrar

  def self.register(data)
    create_provider(data) unless existing_account?(data[:auth])
  end

  private

  def self.existing_account?(auth)
    uid_list(auth).include?(auth[:uid].to_s)
  end

  def self.create_provider(data)
    AppProvider.create_from_omniauth(data)
  end

  def self.uid_list(auth)
    @uids || AppProvider.where(name: auth[:provider]).pluck(:uid)
  end
end
