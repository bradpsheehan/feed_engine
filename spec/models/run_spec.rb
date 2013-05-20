require 'spec_helper'

describe Run do
  let :current_user do
    current_user = User.new()
    current_user.provider = "twitter"
    current_user.uid = "1428947773"
    current_user.name = "runline4"
    current_user.oauth_token = "1428947773-5kMogR0HQWkeEM5ZisRNrvkG2EGgcuLlfOVVD4K"
    current_user.oauth_secret = "Diu5BLQkrnR4ivVVUrnCZ14LSApWQWi4wdCcRuElLE"
    current_user.save!
    current_user
  end

  let :runline3 do
    runline3 = User.new()
    runline3.provider = "twitter"
    runline3.uid = "1426604066"
    runline3.name = "RunLine3"
    runline3.oauth_token = "1426604066-fJtyEG3BaDTP3PrD3v7tACxXVwaFKnOj40mn3EB"
    runline3.oauth_secret = "07yRkLIBSFRi6IoOysWQzRmlwcsZLGjgRKH5CwrfKw"
    runline3.save!
    runline3
  end

  let :attributes do
    {
      name: "Run Name",
      date: "5/23/2013",
      time: "5:12pm",
      details: "run run run",
      route_id: 1
    }
  end

  describe "create_with_invitees(invitees)" do
    it "creates a new run and user_run" do
      VCR.use_cassette('create a run') do
        runs_count = Run.all.count
        Run.create_with_invitees(["runline3"], attributes)
        expect(Run.all.count).to eq(runs_count + 1)
        expect(run.user_runs).to eq 1
      end
    end

    xit "sends tweets to each invitee" do

    end
  end

  describe "Run.invite_runners(run_creator, run, invitees)" do
    xit "creates users who don't exist" do
      VCR.use_cassette('invite_and_create_runners') do
        current_user
        user_count = User.all.count
        run = Run.new
        run.name = "fake run"
        run.save!
        invitees = ["RunLine3"]
        run.invite_runners(invitees)
        expect(User.all.count).to be(user_count + 1)
      end
    end

    xit "doesn't create users who already exist" do
      VCR.use_cassette('invite_and_dont_create_runners') do
        current_user
        runline3
        user_count = User.all.count
        run = Run.new
        run.name = "fake run"
        run.save!
        invitees = ["RunLine3"]
        run.invite_runners(invitees)
        expect(run.users).to be(user_count)
      end
    end

    xit "creates user_runs for all invitees" do
      VCR.use_cassette('invite_and_create_user_runs') do
        user_run_count = UserRun.all.count
        run = Run.new
        run.name = "fake run"
        run.save!
        invitees = %w(RunLine3 runline5 runline6 runline7 runline8)
        run.invite_runners(invitees)
        expect(run.user_runs).to eq(invitees.length)
      end
    end
  end

end
