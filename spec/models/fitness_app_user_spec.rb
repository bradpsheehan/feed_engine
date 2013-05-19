require 'spec_helper'

describe FitnessAppUser do
  it "is valid with required attributes" do
    fitness_user = build(:fitness_app_user)
    expect(fitness_user).to be_valid
  end

  it "is not valid without a uid" do
    fitness_user = build(:fitness_app_user, uid: nil)
    expect(fitness_user).to_not be_valid
  end

  it "is not valid without a provider" do
    fitness_user = build(:fitness_app_user, provider: nil)
    expect(fitness_user).to_not be_valid
  end

  it "is not valid without a name" do
    fitness_user = build(:fitness_app_user, name: nil)
    expect(fitness_user).to_not be_valid
  end

  it "is not valid without an associated user" do
    fitness_user = build(:fitness_app_user, user_id: nil)
    expect(fitness_user).to_not be_valid
  end
end
