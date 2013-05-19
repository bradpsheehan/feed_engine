require 'spec_helper'

describe CheckTwitterResponses do
  include Rails.application.routes.url_helpers

  describe "CheckTwitterResponses.get_results(search_params)" do
    it "returns lots of results" do
      VCR.use_cassette('obama_twitter_results') do
        results = CheckTwitterResponses.get_results("#obama")
        expect(results.count).to be > 1
      end
    end
  end
end
