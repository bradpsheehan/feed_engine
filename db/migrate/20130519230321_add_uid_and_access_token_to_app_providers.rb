class AddUidAndAccessTokenToAppProviders < ActiveRecord::Migration
  def change
    add_column :app_providers, :uid, :string
    add_column :app_providers, :access_token, :string
    remove_column :app_providers, :data
  end
end
