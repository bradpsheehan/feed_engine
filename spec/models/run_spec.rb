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

  describe "Run.create(run_creator, name, invitees)" do
    it "creates a new run and user_run" do
      VCR.use_cassette('create a run') do
        runs_count = Run.all.count
        user_runs_count = UserRun.all.count
        Run.create_with_creator_and_invitees(current_user, "test run", "runline3")
        expect(Run.all.count).to be (runs_count + 1)
        expect(UserRun.all.count).to be (user_runs_count + 2)
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
        run.save!
        invitees = "RunLine3"
        Run.invite_runners(current_user, run, invitees)
        expect(User.all.count).to be (user_count + 1)
      end
    end

    it "doesn't create users who already exist" do
      VCR.use_cassette('invite_and_dont_create_runners') do
        current_user
        runline3
        user_count = User.all.count
        run = Run.new
        run.name = "fake run"
        run.save!
        invitees = "RunLine3"
        Run.invite_runners(current_user, run, invitees)
        expect(User.all.count).to be (user_count)
      end
    end

    it "creates user_runs for all invitees" do
      VCR.use_cassette('invite_and_create_user_runs') do
        user_run_count = UserRun.all.count
        run = Run.new
        run.name = "fake run"
        run.save!
        invitees = "RunLine3, runline5, runline6, runline7, runline8"
        Run.invite_runners(current_user, run, invitees)
        expect(UserRun.all.count).to be (user_run_count + 5)
      end
    end
  end

end
