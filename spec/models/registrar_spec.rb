require 'spec_helper'

describe Registrar do

  describe "#register" do

    before do
      @user = double('user')
      @data = {auth: {stuff: "stuff"}, user: @user}
    end

    it "calls create_provider method when account does not already exist" do
      Registrar.stub(:uid_exists?).and_return(false)
      Registrar.should_receive(:create_provider).with(@data)
      Registrar.register(@data)
    end

    context "uid exists" do

      it "does not call create_provider method when account already exists" do
        Registrar.stub(:uid_exists?).and_return(true)
        Registrar.stub(:current_user_uid_match?).with(@data).and_return(true)
        Registrar.should_not_receive(:create_provider).with(@data)
        Registrar.register(@data)
      end

      it "returns false if current user uid does not match the payload's uid" do
        Registrar.stub(:uid_exists?).and_return(true)
        Registrar.stub(:current_user_uid_match?).with(@data).and_return(false)
        expect(Registrar.register(@data)).to be_false
      end

      it "returns true if current user uid matches the payload's uid" do
        Registrar.stub(:uid_exists?).and_return(true)
        Registrar.stub(:current_user_uid_match?).with(@data).and_return(true)
        expect(Registrar.register(@data)).to be_true
      end
    end
  end

end
