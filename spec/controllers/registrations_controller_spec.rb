require 'spec_helper'

describe RegistrationsController do
  describe "POST .create" do

    before do
      user = double('user')
      @data = {auth: {stuff: "stuff"}, user: user}
      controller.should_receive(:get_runs)
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
    before do
      @user = create(:user)
      @user.stub(:username).and_return("justreem")
      @provider = double('provider')
      controller.stub(:current_user).and_return(@user)
    end

    it "should redirect to new run page after successfully creating a provider" do
      AppProvider.stub(:new).and_return(@provider)
      @provider.stub(:save).and_return(true)
      post :dm_connect
      expect(response).to redirect_to new_run_path
    end

    it "should render the profile page when receiving invalid params"  do
      @provider.stub(:save).and_return(false)
      post :dm_connect, name: "dailymile", username: "name", user_id: @user.id
      expect(response).to render_template :profile
    end
  end

end
