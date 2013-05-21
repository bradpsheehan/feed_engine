require 'spec_helper'

describe Run do
include_context "standard test dataset"

  describe "create_with_invitees(invitees)" do
    it "creates a new run and user_run" do
      VCR.use_cassette('create a run') do
        runs_count = Run.all.count
        run = Run.create_with_invitees(["runline3"], attributes)
        expect(Run.all.count).to eq(runs_count + 1)
        expect(run.user_runs.count).to eq 1
      end
    end

    it "create outstanding_twitter_invites for all invitees" do
      VCR.use_cassette("invites_and_create_twitter_invites") do
        count = OutstandingTwitterInvites.all.count
        invitees = ["RunLine3","runline5","runline6","runline7","runline8"]
        Run.create_with_invitees(invitees, attributes)
        expect(OutstandingTwitterInvites.all.count).to eq(count + 5)
      end
    end
  end

  describe "run#add_invitee" do
    it "creates user_runs with a run_id" do
      VCR.use_cassette("creates_user_runs_with_a_run_id") do
        count = UserRun.all.count
        invitees = ["RunLine3","runline5","runline6","runline7","runline8"]
        run = Run.create_with_invitees(invitees, attributes)
        expect(UserRun.all.count).to eq(count + 5)
        expect(UserRun.last.run_id).to eq run.id
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

    it "doesn't create users who already exist" do
      VCR.use_cassette('invite_and_dont_create_runners') do
        current_user
        runline3
        user_count = User.all.count

        run = Run.new
        run.name = "fake run"
        run.organizer_id = current_user.id
        run.save!

        invitees = ["RunLine3","runline5","runline6","runline7"]
        run.invite_runners(invitees)

        expect(User.all.count).to eq(user_count + 3)
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
