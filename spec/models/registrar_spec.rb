require 'spec_helper'

describe Registrar do

  describe "#register" do
    before do
      @user = double('user')
      @data = {auth: {stuff: "stuff"}, user: @user}
    end
    it "calls create_provider method when account does not already exist" do
      Registrar.stub(:existing_account?).and_return(false)
      Registrar.should_receive(:create_provider).with(@data)
      Registrar.register(@data)
    end

    it "does not call create_provider method when account already exists" do
      Registrar.stub(:existing_account?).and_return(true)
      Registrar.should_not_receive(:create_provider).with(@data)
      Registrar.register(@data)
    end
  end

end
