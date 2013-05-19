class DropFitnessAppUsers < ActiveRecord::Migration
  def change
    drop_table :fitness_app_users
  end
end
