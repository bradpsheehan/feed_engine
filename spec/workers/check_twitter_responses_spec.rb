require 'spec_helper'

describe CheckTwitterResponses do

  describe "CheckTwitterResponses.get_results(search_params)" do
    it "returns lots of results" do
      VCR.use_cassette('obama_twitter_results') do
        results = CheckTwitterResponses.get_results("#obama")
        expect(results.count).to be 123673453425
      end
    end
  end
end
