class OutstandingTwitterInvites < ActiveRecord::Base

  def self.create_invite(invitor, invitee, user_run_id, run_date)
    invite = OutstandingTwitterInvites.new()
    invite.invitor_id = invitor.id
    invite.invitor_twitter_handle = invitor.name
    invite.invitee_id = invitee.id
    invite.invitee_twitter_handle = invitee.name
    invite.invitee_user_run_id = user_run_id
    invite.run_date = run_date
    invite.save!
  end
end
