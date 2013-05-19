class AddProvidersTable < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string  :name
      t.text    :data
      t.integer :user_id

      t.timestamps
    end
  end

end
