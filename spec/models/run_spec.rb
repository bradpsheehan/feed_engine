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
      run_date: "5/23/2013",
      run_start_time: "5:12pm",
      details: "run run run",
      route_id: 1,
      organizer_id: current_user.id
    }
  end

  describe "create_with_invitees(invitees)" do
    it "creates a new run and user_run" do
      VCR.use_cassette('create a run') do
        runs_count = Run.all.count
        run = Run.create_with_invitees(["runline3"], attributes)
        expect(Run.all.count).to eq(runs_count + 1)
        expect(run.user_runs.count).to eq 1
      end
    end

    xit "sends tweets to each invitee"

    xit "create outstanding_twitter_invites for all invitees" do
      VCR.use_cassette("invites_and_create_twitter_invites") do
        count = OutstandingTwitterInvites.all.count
        invitees = "RunLine3, runline5, runline6, runline7, runline8"
        Run.create("another test run", invitees)
        expect(OutstandingTwitterInvites.all.count).to be (count + 5)
      end
    end
  end

  describe "Run.invite_runners(run_creator, run, invitees)" do
    it "creates users who don't exist" do
      VCR.use_cassette('invite_and_create_runners') do
        current_user
        user_count = User.all.count
        run = Run.new
        run.name = "fake run"
        run.organizer_id = current_user.id
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
        run.organizer_id = current_user.id
        run.save!
        invitees = ["RunLine3"]
        run.invite_runners(invitees)
        expect(run.users.count).to eq(user_count)
      end
    end

    it "creates user_runs for all invitees" do
      VCR.use_cassette('invite_and_create_user_runs') do
        user_run_count = UserRun.all.count
        run = Run.new
        run.name = "fake run"
        run.organizer_id = current_user.id
        run.save!
        invitees = %w(RunLine3 runline5 runline6 runline7 runline8)
        run.invite_runners(invitees)
        expect(run.user_runs.count).to eq(invitees.length)
      end
    end
  end

  describe "confirmed_runners" do

    it "return the confirmed runners" do

      run = Run.create
      user_run = UserRun.create(run_id: run.id, user_id: current_user.id, status: "confirmed")
      expect(run.confirmed_runners).to include(current_user)

    end

    it "includes the organizer" do
      run = Run.create(organizer_id: current_user.id)
      expect(run.confirmed_runners).to include(current_user)
    end

  end
end
