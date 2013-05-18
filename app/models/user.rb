class User < ActiveRecord::Base
  has_many :user_runs
  has_many :runs, :through => :user_runs

  validates :name, :uniqueness => true

  def mentions
    @mentions ||= twitter.mentions_timeline
  end

  def friends_tweets
    @friends_tweets = []
    friends.each do |friend|
      @friends_tweets << twitter.search("from:#{friend.screen_name}").results
    end
    @friends_tweets = @friends_tweets.flatten
  end

  def timeline
    @timeline ||= twitter.user_timeline
  end

  def friends
    @friends ||= twitter.friends
  end

  def tweet(status)
    current_user.twitter.update(status)
  end

  def twitter
    @twitter ||= Twitter::Client.new(oauth_token: oauth_token,
                                     oauth_token_secret: oauth_secret)
  end

  def self.create_invited_user(name)
    user = User.new
    user.name = name
    user.status = "invited"
    user.save!
  end

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.oauth_token = auth["credentials"]["token"]
      user.oauth_secret = auth["credentials"]["secret"]
      user.status = "live"
    end
  end
end


