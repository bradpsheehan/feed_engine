class RenameAppProvidersToFitnessApps < ActiveRecord::Migration
  def change
    rename_table :app_providers, :fitness_apps
  end
end
