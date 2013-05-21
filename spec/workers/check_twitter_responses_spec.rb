require 'spec_helper'

describe CheckTwitterResponses do
include_context "standard test dataset"

  include Rails.application.routes.url_helpers

  def create_invitation_from_tweet(tweet)
    invitor = current_user
    invitee = User.find_or_create_by_name(tweet.user.name)
    OutstandingTwitterInvites.create_invite(invitor, invitee, 7, Date.today)
  end

  def create_user_run_from_tweet(tweet)
    invitor = current_user
    invitee = User.find_or_create_by_name(tweet.user.name)
    UserRun.create(run_id: 1, user_id: invitee.id, status: "invited")
  end

  describe "CheckTwitterResponses.perfom" do
    it "does stuff" do
      VCR.use_cassette("check_the_entire_worker") do
        tweets = CheckTwitterResponses.perform
        expect(tweets.count).to eq 15
        expect(OutstandingTwitterInvites.count).to eq 0
        expect(UserRun.count).to eq 0

        tweets.each do |tweet|
          create_invitation_from_tweet(tweet)
          create_user_run_from_tweet(tweet)
        end

        expect(UserRun.all[rand(0..14)].status).to eq "invited"
        expect(UserRun.count).to eq 15
        expect(OutstandingTwitterInvites.count).to eq 15

        CheckTwitterResponses.stub!(:is_reply_to_invitation?).and_return(true)
        CheckTwitterResponses.perform

        expect(UserRun.all[rand(0..14)].status).to eq "confirmed"
        expect(UserRun.count).to eq 15
        expect(OutstandingTwitterInvites.count).to eq 0
      end
    end
  end

  describe "CheckTwitterResponses.destroy_invitations" do
    it "destroys the correct invitations and not the wrong invitations" do
      invitor = current_user
      invitee = runline3
      expect(OutstandingTwitterInvites.all.count).to eq 0
      invitation1 = OutstandingTwitterInvites.create_invite(invitor, invitee,
                                                            4, Date.today)
      invitation2 = OutstandingTwitterInvites.create_invite(invitor, invitee,
                                                            5, Date.today)
      invitation3 = OutstandingTwitterInvites.create_invite(invitee, invitor,
                                                            7, Date.today)
      expect(OutstandingTwitterInvites.all.count).to eq 3
      invitations = CheckTwitterResponses.get_invitations(invitee)
      expect(invitations.count).to eq 2
      CheckTwitterResponses.destroy_invitations(invitations)
      expect(OutstandingTwitterInvites.all.count).to eq 1
      invitations = CheckTwitterResponses.get_invitations(invitee)
      expect(invitations.count).to eq 0
    end
  end

  describe "CheckTwitterResponses.get_invitations(invitee)" do
    it "returns the invitations from an invitee" do
      invitor = current_user
      invitee = runline3
      expect(OutstandingTwitterInvites.all.count).to eq 0
      invitation1 = OutstandingTwitterInvites.create_invite(invitor, invitee,
                                                            4, Date.today)
      invitation2 = OutstandingTwitterInvites.create_invite(invitor, invitee,
                                                            5, Date.today)
      invitation3 = OutstandingTwitterInvites.create_invite(invitee, invitor,
                                                            7, Date.today)
      expect(OutstandingTwitterInvites.all.count).to eq 3
      invitations = CheckTwitterResponses.get_invitations(invitee)
      expect(invitations.count).to eq 2
    end
  end


  describe "CheckTwitterResponses.is_reply_to_invitation?(tweet)" do
    it "verifies the tweet doesn't match any in the twitter invites table" do
      VCR.use_cassette("tweets_dont_match") do
        tweets = CheckTwitterResponses.get_tweets("hi")
        tweet = tweets.first
        expect(tweet.in_reply_to_user_id).to be 16071065
        expect(tweet.in_reply_to_screen_name).to eq "steveabraham"
        invitor = current_user
        invitor.name = "steveabraham333333"
        invitor.save
        OutstandingTwitterInvites.create_invite(invitor, runline3, 4, Date.today)
        response = CheckTwitterResponses.is_reply_to_invitation?(tweet)
        expect(response).to eq false
      end
    end

    it "verifies the tweet matches a tweet in the twitter invites table" do
      VCR.use_cassette("tweets_dont_match") do
        tweets = CheckTwitterResponses.get_tweets("hi")
        tweet = tweets.first
        expect(tweet.in_reply_to_user_id).to be 16071065
        expect(tweet.in_reply_to_screen_name).to eq "steveabraham"
        invitee = current_user
        invitee.name = tweet.user.name
        invitee.save
        OutstandingTwitterInvites.create_invite(runline3, invitee, 4, Date.today)
        response = CheckTwitterResponses.is_reply_to_invitation?(tweet)
        expect(response).to eq true
      end
    end
  end

  describe "CheckTwitterResponses.update_user_runs(invitor, invitee)" do
    it "updates all invitee runs associted w/ invitor to confirmed status" do
      invitor = current_user
      invitee = runline3
      UserRun.create(run_id: 1, user_id: invitee.id, status: "invited")
      invitee_user_run = UserRun.last
      expect(invitee_user_run.status).to eq "invited"
      CheckTwitterResponses.update_user_runs(invitor, invitee)
      new_invitee_user_run = UserRun.last
      expect(new_invitee_user_run.status).to eq "confirmed"
    end
  end

  describe "CheckTwitterResponses.update_invitee(invitee)" do
    it "updates the invitee user record" do
      invitee  = User.create_invited_user("test_invitee")
      expect(invitee.status).to eq "invited"
      CheckTwitterResponses.update_invitee(invitee)
      expect(invitee.status).to eq "confirmed"
    end
  end

  describe "CheckTwitterResponses.get_runners(tweet)" do
    it "gets the invitor and invitee" do
      VCR.use_cassette("gets_invitor_and_invitee") do
        tweets = CheckTwitterResponses.get_tweets("hi")
        tweet = tweets.last
        expect(tweet.in_reply_to_user_id).to eq 83732151
        expect(tweet.in_reply_to_screen_name).to eq "Hi_IamAaron"
        expect(tweet.user.name).to eq "Lamar"
        real_invitee = User.new()
        real_invitee.name = tweet.user.name
        real_invitee.save!
        real_invitor = User.new()
        real_invitor.name = tweet.in_reply_to_screen_name
        real_invitor.save!
        invitor, invitee = CheckTwitterResponses.get_runners(tweet)
        expect(invitor).to eq real_invitor
        expect(invitee).to eq real_invitee
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
