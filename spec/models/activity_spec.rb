require 'spec_helper'

describe Activity do
  it "is valid with required attributes" do
    activity = build(:activity)
    expect(activity).to be_valid
  end

  it "is not valid without a duration" do
    activity = build(:activity, duration: nil)
    expect(activity).to_not be_valid
  end

  it "is not valid without a distance" do
    activity = build(:activity, distance: nil)
    expect(activity).to_not be_valid
  end

  it "is not valid without an activity_id" do
    activity = build(:activity, activity_id: nil)
    expect(activity).to_not be_valid
  end

  it "is not valid without an associated user" do
    activity = build(:activity, user_id: nil)
    expect(activity).to_not be_valid
  end

end
