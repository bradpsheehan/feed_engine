class CreateFitnessApps < ActiveRecord::Migration
  def change
    create_table :fitness_apps do |t|
      t.string    :provider
      t.string    :uid
      t.string    :access_token
      t.string    :name
      t.integer   :user_id

      t.timestamps
    end
  end
end
