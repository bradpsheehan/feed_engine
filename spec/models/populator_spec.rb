require 'spec_helper'

describe Populator do

  describe "#create_activity" do

    before do
      @user = create(:user)
      @data = {
        "type" => "running",
        "duration" =>  5757.987,
        "total_distance" =>  557.987,
        "start_time" => "Wed, 10 Oct 2012 19:09:29",
        "uri" =>  "/fitnessActivities/124069314",
        "run_detail" =>  {"climb" => "stuff"}
      }
    end

    it "saves record to the database" do
      Populator.stub(:get_activity_id).and_return("124069314")
      expect {
        Populator.create_activity(@data, @user)
      }.to change(Activity, :count).by(1)
    end
  end

  describe "#add_activity_list" do
    # help_needed!

    before do
      ResqueSpec.reset!
      @user = create(:user)
      @activity1 = create(:activity)
      @activity2 = build(:activity)
      @data = RunkeeperData.items
    end

    it "Background worker is called" do
      pending
      user_activities = [@activity1.activity_id]
      Resque.stub(:enqueue)
      Populator.stub(:get_user_activities).and_return(user_activities)
      Populator.add_activity_list(@data, @user)
      # FetchRunData.should have_queued(@activity2, @user.id).in(:fetch_runs)
      FetchRunData.should have_queue_size_of(44)
    end
  end

  describe "#get_activity_id" do

    it "should correctly parse uri string and return activity_id" do
      uri = "/fitnessActivities/124069314"
      activity_id = Populator.get_activity_id(uri)
      expect(activity_id).to eq("124069314")
    end
  end

  describe "#get_user_activities" do
    before do
      @user = create(:user)
      @activity1 = create(:activity, user_id: 1)
      @activity2 = create(:activity, user_id: 1)
    end

    it "should return the correct number of activities for the user" do
      activities = Populator.get_user_activities(@user)
      expect(activities.length).to eq 2
    end
  end
end
