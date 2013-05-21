class RunsController < ApplicationController

  before_filter :check_user_logged_in

  def create
    unless params[:route][:name].empty?
      route = Route.create(params[:route])
      params[:run][:route_id] = route.id
    end

    params[:run][:organizer_id] = current_user.id
    params[:run][:run_date] = Chronic.parse(params[:run][:run_date])
    friends = params[:friends].gsub(" ", "").split(",")
    run = Run.create_with_invitees(friends, params[:run])
    redirect_to run
  end

  def index
    @runs = Run.all
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
    if params[:cancel] && @run.organizer_id == current_user.id
      @run.cancel
    end

    redirect_to @run
  end

end


