class RunsController < ApplicationController

  before_filter :check_user_logged_in
  before_filter :clean_params, only: :create

  def create
    run = Run.create_with_invitees(params[:friends], params[:run])
    redirect_to run
  end

  def index
    @runs = current_user.all_runs
  end

  def show
    @run = Run.find_by_id(params[:id])
  end

  def new
    @run = Run.new
    @routes = Route.all
  end

  def update
    @run = Run.find_by_id(params[:id])
    if params[:cancel] && @run.can_edit?(current_user)
      @run.cancel
    end

    redirect_to @run
  end

  def clean_params
    params[:run][:route_id] = clean_route
    params[:run][:organizer_id] = current_user.id

    params[:run][:started_at] = clean_started_at

    params[:friends] = clean_friends(params[:friends])

  end

  def clean_route
    unless params[:route][:name].empty?
      route = Route.create(params[:route])
      params[:run][:route_id] = route.id
    else
      params[:run][:route_id]
    end
  end

  def clean_friends friends
    friends.gsub("@", "").gsub(" ", "").split(",")
  end

  def clean_started_at
    Chronic.parse(params[:run_date]+" "+params[:start_time])

  end

end


