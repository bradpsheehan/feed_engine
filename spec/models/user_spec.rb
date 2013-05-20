require 'spec_helper'

describe User do
  let :current_user do
    current_user = User.new()
    current_user.provider = "twitter"
    current_user.uid = "1428947773"
    current_user.name = "runline4"
    current_user.oauth_token = "1428947773-5kMogR0HQWkeEM5ZisRNrvkG2EGgcuLlfOVVD4K"
    current_user.oauth_secret = "Diu5BLQkrnR4ivVVUrnCZ14LSApWQWi4wdCcRuElLE"
    current_user.save!
    current_user
  end

  describe "User.create_from_omniauth(auth)" do
    it "creates a user" do
      auth = {}
      auth["provider"] = "twitter"
      auth["uid"] = "1234"
      auth["info"] = {}
      auth["info"]["nickname"] = "buster"
      auth["credentials"] = {}
      auth["credentials"]["token"] = "token"
      auth["credentials"]["secret"] = "secret"
      user_count = User.all.count
      User.create_from_omniauth(auth)
      expect(User.all.count).to be(user_count + 1)
    end
  end

  describe "User.from_omniauth(auth)" do
    it "creates a user when one doesn't exist" do
      auth = {}
      auth["provider"] = "twitter"
      auth["uid"] = "1234"
      auth["info"] = {}
      auth["info"]["nickname"] = "buster2"
      auth["credentials"] = {}
      auth["credentials"]["token"] = "token"
      auth["credentials"]["secret"] = "secret"
      user_count = User.all.count
      User.from_omniauth(auth)
      expect(User.all.count).to be(user_count + 1)
    end

    it "doesn't create a user and finds the user if they already exist" do
      auth = {}
      auth["provider"] = "twitter"
      auth["uid"] = "1234"
      auth["info"] = {}
      auth["info"]["nickname"] = "buster3"
      auth["credentials"] = {}
      auth["credentials"]["token"] = "token"
      auth["credentials"]["secret"] = "secret"
      User.from_omniauth(auth)
      user_count = User.all.count
      User.from_omniauth(auth)
      expect(User.all.count).to be(user_count)
    end
  end

  describe "User.create_invited_user(name)" do
    it "creates a user with status 'invited'" do
      user_count = User.all.count
      User.create_invited_user("jimmy")
      expect(User.all.count).to be(user_count+1)
    end
  end

  describe "User #friends" do
    it "shows that the user has friends (is following people)" do
      VCR.use_cassette('user') do
        friends = current_user.friends
        expect(friends.users.class).to be Array
        expect(friends.users[0].friends_count).to be > 5
      end
    end
  end

  describe "User #tweet" do
    it "tweets" do
      expect(current_user.respond_to?(:tweet))
    end
  end

  describe "User #friends_tweets" do
    it "shows that the users friends have tweets" do
      VCR.use_cassette('friends_tweets') do
        friends_tweets = current_user.friends_tweets
        expect(friends_tweets.class).to be Array
        expect(friends_tweets.count).to be > 5
      end
    end
  end

  describe "User #timeline" do
    it "shows that the user has tweets on his timeline" do
      VCR.use_cassette('user1') do
        timeline = current_user.timeline
        expect(timeline.class).to be Array
        expect(timeline.count).to be > 0
      end
    end
  end

  describe "User #mentions" do
    it "shows that the user has mentions" do
      VCR.use_cassette("mentions") do
        mentions = current_user.mentions
        expect(mentions.class).to be Array
        expect(mentions.count).to be > 0
        expect(mentions[0][:text]).to include "@runline4"
      end
    end
  end

end

