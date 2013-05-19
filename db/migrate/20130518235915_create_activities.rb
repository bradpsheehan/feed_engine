class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|

      t.string   :activity_type
      t.string   :provider
      t.float    :duration
      t.float    :distance
      t.datetime :activity_date
      t.string   :activity_id
      t.integer  :user_id
      t.boolean  :detail_present, :default => false
      t.text     :run_detail

      t.timestamps
    end
  end
end
