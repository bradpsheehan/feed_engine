require 'spec_helper'

describe OutstandingTwitterInvites do

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

  describe ".create_invite(invitor, invitee, user_run_id, run_date)" do
    it "should create_invite" do
      count = OutstandingTwitterInvites.all.count
      OutstandingTwitterInvites.create_invite(
        current_user,
        runline3,
        2,
        Date.today)
      expect(OutstandingTwitterInvites.all.count).to be (count + 1)
    end
  end

  describe ".create" do
    it "should create" do
      count = OutstandingTwitterInvites.all.count
      invite = OutstandingTwitterInvites.new()
      invite.invitor_id = 1
      invite.invitor_twitter_handle = "derp"
      invite.invitee_id = 2
      invite.invitee_twitter_handle = "derp2"
      invite.invitee_user_run_id = 1
      invite.run_date = Date.today
      invite.save!
      expect(OutstandingTwitterInvites.all.count).to be (count + 1)
    end
  end

  describe ".destroy" do
    it "should destroy" do
      count = OutstandingTwitterInvites.all.count
      invite = OutstandingTwitterInvites.new()
      invite.invitor_id = 1
      invite.invitor_twitter_handle = "derp"
      invite.invitee_id = 2
      invite.invitee_twitter_handle = "derp2"
      invite.invitee_user_run_id = 1
      invite.run_date = Date.today
      invite.save!
      expect(OutstandingTwitterInvites.all.count).to be (count + 1)
      invite.delete
      expect(OutstandingTwitterInvites.all.count).to be (count)
    end

  end
end
