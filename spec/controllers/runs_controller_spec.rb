require 'spec_helper'

describe RunsController do

  before do
    controller.stub(:check_user_logged_in)
  end
  describe "create" do

    let(:date) {  "05/23/2012"}
    let(:time) {"5:00 pm"}

    let(:expected_attributes) do
      {
        route_id: "1",
        organizer_id: 3,
        started_at: Chronic.parse(date+" "+time),
        details: "details",
        name: "name"
      }.with_indifferent_access
    end

    let(:friends){['lalalainexd', 'runline1', 'runline2']}

    let(:attributes)  do
      {
        friends: 'lalalainexd, runline1, @runline2',
        run: {
        name: "name",
        details: "details",
        route_id: 1,
        organizer_id: 3
      },
        run_date: date,
        start_time: time,
        route: {
          name: ""
        }
      }.with_indifferent_access
    end

    before do
      controller.stub(:current_user).and_return(double(:current_user, id: 3))
    end

    it "should create a run and send invites" do
      Run.should_receive(:create_with_invitees).with(friends, expected_attributes).and_return(Run.new)
      post :create, attributes
    end

    context "with a new route" do

      it "should create the route" do
        attributes[:route] = {name: "route"}.with_indifferent_access
        Run.stub(:create_with_invitees).and_return(Run.new)
        Route.should_receive(:create).with(attributes[:route]).and_return(Route.new)
        post :create, attributes

      end
    end

  end

  describe "index" do
    it "returns all of the user's group runs" do
      user = User.new
      controller.stub(:current_user).and_return(user)
      user.should_receive(:all_runs)

      get :index

    end
  end

  describe "update" do
    context "cancelling a run" do
      it "cancels the run" do
        controller.stub(:current_user).and_return(User.new)
        run = Run.new
        Run.should_receive(:find_by_id).and_return(run)
        run.should_receive(:can_edit?).and_return(true)
        run.should_receive(:cancel)

        post :update, id: 1, cancel: true


      end
    end
  end

end
