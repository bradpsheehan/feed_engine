class AddUsernameToAppProviders < ActiveRecord::Migration
  def change
    add_column :app_providers, :username, :string
  end
end
