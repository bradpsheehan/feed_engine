class CheckTwitterResponses
  @queue = :check_for_yes_responses_to_runs_queue

  def self.perform
    results = get_results("#runline #yes")
    results.each do |result|
      if is_result_a_retweet?(result)
        invitor, invitee = get_runners(result)
        invitee.status == "confirmed" if invitee.status == "invited"
        update_user_runs(invitor, invitee, result)
      end
    end
  end

  def self.get_results(search_params)
    Twitter.search(search_params).results
  end

  def self.is_result_a_retweet?(tweet)
    tweet.in_reply_to_status_id != nil
  end

  def self.get_runners(tweet)
    #for each remaining tweet
    #pull out the username (@invitor) of the original tweeter
    invitor = User.find_by_name(tweet.id_of_tweeted_from)
    #pull out the username (@invitee) of the runner joing the run
    invitee = User.find_by_name(tweet.username)
    return invitor, invitee
  end

  def self.update_user_runs(invitor, invitee, result)
    #find a run that has user_runs with both the @invitor and @invitee's user ids
    invitee_user_runs = UserRuns.find_all_by_user_id(invitee.id)
    invitee_user_runs.each do |user_run|
      if invitor.in_run(user_run) == true
        #update the corresponding @invitee's user_run status with "confirmed"
        user_run.status == "confirmed"
        user_run.save!
      end
    end
  end

end
