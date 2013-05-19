class CheckTwitterResponses
  @queue = check_for_yes_responses_to_runs_queue

  def self.perform
    results = get_results("#runline #yes")
    #parse out the tweets sent by our app
    results.each do |result|
      if is_result_a_retweet(result)
        invitor, invitee = get_runners(result)
        invitee.status == "confirmed" if invitee.status == "invited"
        update_user_runs(invitor, invitee, result)
      end
    end
  end

  def self.get_results(search_params)
    #search twitter for texts with the hashtags #runline and #yes
    Twitter.search(search_params).results
  end

  def self.is_result_a_retweet(result)

  end

  def self.get_runners(result)
    #for each remaining tweet
    #pull out the username (@invitor) of the original tweeter
    invitor = User.find_by_name(result.id_of_tweeted_from)
    #pull out the username (@invitee) of the runner joing the run
    invitee = User.find_by_name(result.username)
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
