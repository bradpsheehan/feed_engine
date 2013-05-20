require 'spec_helper'

describe CheckTwitterResponses do
include_context "standard test dataset"

  include Rails.application.routes.url_helpers

  describe "CheckTwitterResponses.is_reply_to_invitation?(tweet)" do
    it "verifies the tweet doesn't match any in the twitter invites table" do
      tweet = stub(tweet, :in_reply_to_status_id => nil)
      reply = CheckTwitterResponses.is_reply_to_invitation?(tweet)
      expect(reply).to be false
    end

    it "verifies the tweet matches a tweet in the twitter invites table" do
      VCR.use_cassette("tweet_matching") do
        runs_count = Run.all.count
        invites_count = OutstandingTwitterInvites.all.count
        run = Run.create_with_invitees(["runline3"], attributes)
        expect(Run.all.count).to eq(runs_count + 1)
        expect(OutstandingTwitterInvites.all.count).to eq(invites_count + 1)


        # tweet = stub(tweet, :in_reply_to_status_id => 345)
        # run = Run.create()
        # user_run = UserRun.create(user_id: runline3.id, status: "invited")
        # OutstandingTwitterInvites.create_invite(current_user, runline3,
        #                                         user_run.id, run_date)
        # reply = CheckTwitterResponses.is_reply_to_invitation?(tweet)
        # expect(reply).to be true
      end
    end
  end

  describe "CheckTwitterResponses.get_tweets(search_params)" do
    it "returns lots of results" do
      VCR.use_cassette('obama_twitter_results') do
        results = CheckTwitterResponses.get_tweets("#obama")
        expect(results.count).to be > 1
        expect(results.class).to be Array
        expect(results.first.class).to be Twitter::Tweet
      end
    end
  end

  describe "CheckTwitterResponses.is_result_a_retweet?(result)" do
    it "shows that it isn't a retweet and returns false" do
      tweet = stub(tweet, :in_reply_to_status_id => nil)
      retweet = CheckTwitterResponses.is_result_a_retweet?(tweet)
      expect(retweet).to be false
    end

    it "shows that is is a retweet and returns true" do
      tweet = stub(tweet, :in_reply_to_status_id => 123124124)
      retweet = CheckTwitterResponses.is_result_a_retweet?(tweet)
      expect(retweet).to be true
    end
  end
end
