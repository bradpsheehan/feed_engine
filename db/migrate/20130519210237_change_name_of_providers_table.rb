class ChangeNameOfProvidersTable < ActiveRecord::Migration
  def change
    rename_table :providers, :app_providers
  end
end
