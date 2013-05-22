require 'spec_helper'

describe RegistrationsController do
  describe "POST .create" do

    before do
      @user = double('user', app_token: "token")
      @data = {auth: {stuff: "stuff"}, user: @user}
    end

    it "should successfully call Registrar#register" do
      controller.stub(:current_user).and_return(@user)
      Client::API.stub(:get_runs)
      Registrar.stub(:register)
      Registrar.should_receive(:register)

      post :create
    end

    context "successful authentication" do
      it "should redirect to new run path" do
        controller.stub(:current_user).and_return(@user)
        Client::API.stub(:get_runs)
        Registrar.stub(:register).and_return(true)

        post :create
        expect(response).to redirect_to new_run_path
      end
    end

    context "unsuccessful authentication" do
      it "should render profile template with error message " do
        controller.stub(:current_user).and_return(@user)
        Client::API.stub(:get_runs)
        Registrar.stub(:register).and_return(false)
        post :create
        expect(response).to render_template 'users/profile'
      end
    end
  end

  describe "POST .dm_connect" do

  end

end
