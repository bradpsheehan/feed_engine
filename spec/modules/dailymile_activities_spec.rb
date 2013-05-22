require 'spec_helper'

describe Dailymile::Activities do

  describe ".for_user" do
    it "returns an array of activities" do
      VCR.use_cassette 'dm_activities' do
        username = "justreem"
        expect(Dailymile::Activities.new.for_user(username).length).to eq 2
      end
    end
  end


end
