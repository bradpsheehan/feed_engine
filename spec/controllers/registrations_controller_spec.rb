require 'spec_helper'

describe RegistrationsController do
  describe "POST .create" do

    before do
      user = double('user')
      @data = {auth: {stuff: "stuff"}, user: user}
      controller.should_receive(:get_runs)
    end

    it "should successfully call Registrar#register" do
      Registrar.stub(:register)
      Registrar.should_receive(:register)

      post :create
    end

    context "successful authentication" do
      it "should redirect to new run path" do
        Registrar.stub(:register).and_return(true)

        post :create
        expect(response).to redirect_to new_run_path
      end
    end

    context "unsuccessful authentication" do
      it "should render profile template with error message " do
        Registrar.stub(:register).and_return(false)
        post :create
        expect(response).to render_template 'users/profile'
      end
    end


  end
end
