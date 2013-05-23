require 'spec_helper'

describe Dailymile::Activities do

  describe ".for_user" do
    it "calls Populator@add_dm_activities" do
      user = double('user')
      user.stub(:username).and_return("justreem")
      Populator.stub(:add_dm_activities)
      Populator.should_receive(:add_dm_activities)

      VCR.use_cassette 'dm_activities' do
        Dailymile::Activities.new.for_user(user)
      end

    end
  end


end
