class CheckTwitterResponses
  @queue = :check_for_yes_responses_to_runs_queue

  def self.perform
    tweets = get_tweets("#yes")
    tweets.each do |tweet|
      if is_reply_to_invitation?(tweet)
        invitor, invitee = get_runners(tweet)
        invitee.status == "confirmed" if invitee.status == "invited"
        update_user_runs(invitor, invitee, tweet)
      end
    end
  end

  def self.get_tweets(search_params)
    Twitter.search(search_params).results
  end

  def self.is_result_a_retweet?(tweet)
    tweet.in_reply_to_status_id != nil
  end

  def self.get_runners(tweet)
    invitor = User.find_by_name(tweet.id_of_tweeted_from)
    invitee = User.find_by_name(tweet.username)
    return invitor, invitee
  end

  def self.update_user_runs(invitor, invitee, result)
    invitee_user_runs = UserRuns.find_all_by_user_id(invitee.id)
    invitee_user_runs.each do |user_run|
      if invitor.in_run(user_run) == true
        user_run.status == "confirmed"
        user_run.save!
      end
    end
  end
end
