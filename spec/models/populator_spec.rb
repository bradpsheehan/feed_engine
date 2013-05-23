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

    before do
      @user = create(:user)
      @activity1 = create(:activity)
      @activity2 = build(:activity)
      @data = RunkeeperData.items
    end

    it "Background worker is called" do
      user_activities = [@activity1.activity_id]
      Resque.stub(:enqueue)
      Resque.should_receive(:enqueue).exactly(45).times
      Populator.stub(:get_user_activities).and_return(user_activities)
      Populator.add_activity_list(@data, @user)
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
      @activity1 = create(:activity, user_id: 1, provider: "runkeeper")
      @activity2 = create(:activity, user_id: 1, provider: "runkeeper")
    end

    xit "should return the correct number of activities for the user" do
      activities = Populator.get_user_activities(@user, "runkeeper")
      expect(activities.length).to eq 2
    end
  end

  describe "#create_dm_activities" do

    before do
      @data = {"id" => "323453454",
                      "at" => "2013-05-21T15:03:19Z",
                      "workout" => {"activity_type" => "Running",
                                    "distance" => {"value" => 2.69},
                                    "duration" => 1153}}
      @user = create(:user)
      @provider = 'dailymile'
    end

    it "saves dailymile activity to the database" do
      expect {
        Populator.create_dm_activities(@data, @user, @provider)
      }.to change(Activity, :count).by(1)
    end

  end

  describe "#add_dm_activties" do
    before do
      @data = [{"id" => "323453454",
                      "at" => "2013-05-21T15:03:19Z",
                      "workout" => {"activity_type" => "Running",
                                    "distance" => {"value" => 2.69},
                                    "duration" => 1153}},
               {"id" => "32389754",
                      "at" => "2013-05-21T15:03:19Z",
                      "workout" => {"activity_type" => "Running",
                                    "distance" => {"value" => 2.69},
                                    "duration" => 1153}}]

      @user = create(:user)
      @provider = 'dailymile'
    end

    it "should call #create_dm_activities the correct # of times" do
      Populator.stub(:get_user_activities).and_return(["sfsfsd"])
      Populator.should_receive(:create_dm_activities).exactly(2).times
      Populator.add_dm_activities(@data, @user, @provider)
    end
  end
end
