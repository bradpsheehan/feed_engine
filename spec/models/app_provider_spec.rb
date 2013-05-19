require 'spec_helper'

describe AppProvider do
  it "is valid with required attributes" do
    app_provider = build(:app_provider)
    expect(app_provider).to be_valid
  end

  it "is not valid without a name" do
    app_provider = build(:app_provider, name: nil)
    expect(app_provider).to_not be_valid
  end

  it "is not valid without an associated user" do
    app_provider = build(:app_provider, user_id: nil)
    expect(app_provider).to_not be_valid
  end
end
