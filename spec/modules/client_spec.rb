require 'spec_helper'

describe Client::API do
  it "should exist" do
    expect(Client::API.class).to equal Module
  end

  describe "#get_runs" do

    before do
      @user = double('user')
      @data = {token: "sdfsdfsd", user: @user}
      @runs = OpenStruct.new("body" => {"source" => "runkeeper"})
      @rk_user = double('rk_user')
    end

    it "makes a call to Populator object to add data to database" do
      Runkeeper::User.stub(:new).with(@data[:token]).and_return(@rk_user)
      @rk_user.stub(:fitness_activities_feed).and_return(@runs)
      Populator.should_receive(:add_activity_list).with(@runs.body, @data[:user])
      Client::API.get_runs(@data)
    end

    it "makes a call to the API interface and returns runkeeper user obj" do
      Runkeeper::User.should_receive(:new).with(@data[:token]).and_return(@rk_user)
      @rk_user.stub(:fitness_activities_feed).and_return(@runs)
      Populator.stub(:add_activity_list).with(@runs.body, @data[:user])
      Client::API.get_runs(@data)
    end

    it "uses runkeeper user object to retreive list of runs"  do
      Runkeeper::User.stub(:new).with(@data[:token]).and_return(@rk_user)
      @rk_user.should_receive(:fitness_activities_feed).and_return(@runs)
      Populator.stub(:add_activity_list).with(@runs.body, @data[:user])
      Client::API.get_runs(@data)
    end
  end

  describe "#get_run_detail" do
    before do
      @user = double('user')
      @data = {token: "sdfsdfsd", id: "21324"}
      @run_detail = OpenStruct.new("body" => {"paths" => [{"path1" => "1"}, {"path2" => "2"}]})
      @rk_user = double('rk_user')

    end

    it "makes a call to the API interface and returns runkeeper user obj" do
      Runkeeper::User.should_receive(:new).with(@data[:token]).and_return(@rk_user)
      @rk_user.stub(:fitness_activities).and_return(@run_detail)
      Client::API.get_run_detail(@data)
    end

    it "uses runkeeper user object to retreive run detail" do
      Runkeeper::User.stub(:new).with(@data[:token]).and_return(@rk_user)
      @rk_user.should_receive(:fitness_activities).and_return(@run_detail)
      Client::API.get_run_detail(@data)
    end

  end
end

