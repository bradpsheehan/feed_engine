class ChangeFitnessAppsToFitnessUser < ActiveRecord::Migration
  def change
    rename_table :fitness_apps, :fitness_app_users
  end
end
