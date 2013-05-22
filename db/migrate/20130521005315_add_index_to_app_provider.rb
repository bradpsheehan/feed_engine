class AddIndexToAppProvider < ActiveRecord::Migration
  def change
    add_index :app_providers, [:user_id, :uid], unique: true
  end
end
