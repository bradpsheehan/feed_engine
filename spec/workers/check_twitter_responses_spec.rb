require 'spec_helper'

describe CheckTwitterResponses do
  include Rails.application.routes.url_helpers

  describe "CheckTwitterResponses.get_results(search_params)" do
    it "returns lots of results" do
      VCR.use_cassette('obama_twitter_results') do
        results = CheckTwitterResponses.get_results("#obama")
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
