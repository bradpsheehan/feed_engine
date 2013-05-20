require 'spec_helper'

describe RegistrationsController do
  describe "POST .create" do

    before do
      user = double('user')
      @data = {auth: {stuff: "stuff"}, user: user}
    end

    it "should successfully call Registrar#register" do
      Registrar.stub(:register)
      Registrar.should_receive(:register)

      post :create
    end

    it "should redirect to dashboard" do
      Registrar.stub(:register)

      post :create
      expect(response).to redirect_to dashboard_path
    end

  end
end
