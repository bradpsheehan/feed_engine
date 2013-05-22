class CheckTwitterResponses
  @queue = :check_for_yes_responses_to_runs_queue

  def self.perform
    tweets = get_tweets("#yes")
    tweets.each do |tweet|
      if is_reply_to_invitation?(tweet)
        invitor, invitee = get_runners(tweet)
        invitations = get_invitations(invitee)
        destroy_invitations(invitations)
        update_invitee(invitee)
        update_user_runs(invitor, invitee)
      end
    end
    tweets
  end

  def self.get_invitations(invitee)
    invitations ||= OutstandingTwitterInvites.where(invitee_twitter_handle: invitee.name)
  end

  def self.destroy_invitations(invitations)
    invitations.each do |invite|
      invite.delete
    end
  end

  def self.update_user_runs(invitor, invitee)
    invitee_user_runs = UserRun.find_all_by_user_id(invitee.id)
    invitee_user_runs.each do |user_run|
      user_run.status = "confirmed"
      user_run.save!
    end
    invitee_user_runs
  end

  def self.update_invitee(invitee)
    if invitee.status == "invited"
      invitee.status = "confirmed"
      invitee.save!
    end
  end

  def self.is_reply_to_invitation?(tweet)
    invitees ||= OutstandingTwitterInvites.all.to_a.map do |invite|
      invite.invitee_twitter_handle
    end
    return true if invitees.include? tweet.user.name
    false
  end

  def self.get_tweets(search_params)
    Twitter.search(search_params).results
  end

  def self.is_result_a_retweet?(tweet)
    tweet.in_reply_to_status_id != nil
  end

  def self.get_runners(tweet)
    invitor = User.find_by_name(tweet.in_reply_to_screen_name)
    invitee = User.find_by_name(tweet.user.name)
    return invitor, invitee
  end
end
