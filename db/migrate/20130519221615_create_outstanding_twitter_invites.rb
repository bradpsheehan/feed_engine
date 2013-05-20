class CreateOutstandingTwitterInvites < ActiveRecord::Migration
  def change
    create_table :outstanding_twitter_invites do |t|
      t.integer :invitor_id
      t.string  :invitor_twitter_handle
      t.integer :invitee_id
      t.string  :invitee_twitter_handle
      t.integer :invitee_user_run_id
      t.date    :run_date
      t.timestamps
    end
  end
end
