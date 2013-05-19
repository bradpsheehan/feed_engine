require 'spec_helper'

describe Runkeeper::API do
  it "should exist" do
    expect(Runkeeper::API.class).to eq Module
  end

  context "#get" do
    before do

    end

    describe "Runkeeper user obj using /user path" do
      before do
        @user = double(uid: "5234295")
        @header_user = "application/vnd.com.runkeeper.User+json"
        @header_activities = "application/vnd.com.runkeeper.FitnessActivityFeed+json"
        @header_activity = "application/vnd.com.runkeeper.FitnessActivity+json"
        @token = "318092c9fa74468dba0507844d29cf4d"
      end

      it "should fetch Runkeeper user object" do
        VCR.use_cassette 'rk_user' do
          path = "user"
          rk_response = Runkeeper::API.get(path, @header_user, @token)
          expect(rk_response.body.userID).to eq @user.uid.to_i
        end
      end

      it "should fetch Runkeeper activity list" do
        VCR.use_cassette 'rk_activities' do
          path = "/fitnessActivities/?pageSize=50"
          rk_response = Runkeeper::API.get(path, @header_activities, @token)
          expect(rk_response.body.items.count).to eq 45
          expect(rk_response.body.items.first.duration).to eq 3138.844
        end
      end

      it "should fetch Runkeeper activity details" do
        VCR.use_cassette 'rk_activity' do
          id = "84463239"
          path = "/fitnessActivities/#{id}"
          rk_response = Runkeeper::API.get(path, @header_activity, @token)
          expect(rk_response.body.path.count).to eq 397
          expect(rk_response.body.path.first.longitude).to eq -77.044326
          expect(rk_response.body.path.first.latitude).to eq 38.918026
        end
      end
    end
  end
end

