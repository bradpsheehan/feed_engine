require 'spec_helper'

describe SessionsController do

  describe "POST .create" do

    it "redirects to dashboard after authorization" do
      user = double('user', id: 1)
      User.stub(:from_omniauth).and_return(user)
      post :create
      expect(response).to redirect_to dashboard_path
    end

    it "sets session[:user_id] to user.id" do
      user = double('user', id: 1)
      User.stub(:from_omniauth).and_return(user)
      post :create
      expect(session[:user_id]).to eq user.id
    end

    it "renders :new template and does not save user with invalid info" do
      User.stub(:from_omniauth).and_return(nil)
      post :create
      expect(flash[:alert]).to eq "Authentication failed."
    end
  end

  describe "DELETE .destroy" do
    before do
      @user = double('user', id: 1)
      session[:user_id] = @user.id
    end

    it "clears the session[:user_id] value" do
      delete :destroy, id: @user
      expect(session[:user_id]).to be_nil
    end

    it "redirects_to the root_url" do
      delete :destroy, id: @user
      expect(response).to redirect_to root_url
    end
  end
end

