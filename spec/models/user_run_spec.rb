require 'spec_helper'

describe UserRun do
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

  describe "UserRun.create(run_id, user_id, status)" do
    it "creates a user run" do
      count = User.all.count
      UserRun.create(1, current_user.id, "invited")
      expect(User.all.count).to be (count + 1)
    end
  end
end
