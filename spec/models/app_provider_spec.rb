require 'spec_helper'

describe AppProvider do

  describe "an AppProvider instance" do

    it "is valid with required attributes" do
      app_provider = build(:app_provider)
      expect(app_provider).to be_valid
    end

    it "is not valid without a name" do
      app_provider = build(:app_provider, name: nil)
      expect(app_provider).to_not be_valid
    end

    it "is not valid without a uid" do
      app_provider = build(:app_provider, uid: nil)
      expect(app_provider).to_not be_valid
    end

    it "is not valid without an access_token" do
      app_provider = build(:app_provider, access_token: nil)
      expect(app_provider).to_not be_valid
    end

    it "is not valid without an associated user" do
      app_provider = build(:app_provider, user_id: nil)
      expect(app_provider).to_not be_valid
    end

    it "is not valid if user already has a registered provider" do
      existing_provider = create(:app_provider, user_id: 1)
      new_provider = build(:app_provider, user_id: 1)
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
        AppProvider.create_from_omniauth(@data)
      }.to change(AppProvider, :count).by(1)
    end
  end
end
