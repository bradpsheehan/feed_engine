require 'spec_helper'

describe FitnessApp do

  describe "an FitnessApp instance" do

    it "is valid with required attributes" do
      fitness_app = build(:fitness_app)
      expect(fitness_app).to be_valid
    end

    it "is not valid without a name" do
      fitness_app = build(:fitness_app, name: nil)
      expect(fitness_app).to_not be_valid
    end

    it "is not valid without a uid" do
      fitness_app = build(:fitness_app, uid: nil, name: "runkeeper")
      expect(fitness_app).to_not be_valid
    end

    it "is not valid without an access_token" do
      fitness_app = build(:fitness_app, access_token: nil, name: "runkeeper")
      expect(fitness_app).to_not be_valid
    end

    it "is not valid without an associated user" do
      fitness_app = build(:fitness_app, user_id: nil)
      expect(fitness_app).to_not be_valid
    end

    it "is not valid if user already has a registered provider" do
      existing_provider = create(:fitness_app, user_id: 1)
      new_provider = build(:fitness_app, user_id: 1)
      expect(new_provider).to_not be_valid
    end
  end

  describe "#create_from_omniauth" do
    before do
      @user = create(:user)
      @data = { auth: {provider: "runkeeper", uid: "234908", credentials: {token: "2323432534543"}},
                user: @user}
    end

    it "saves record to the database" do
      expect {
        FitnessApp.create_from_omniauth(@data)
      }.to change(FitnessApp, :count).by(1)
    end
  end
end
