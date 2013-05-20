class RunsController < ApplicationController

  def create
    run_info = {}
    run_info[:run_date] = Date.parse(params[:date])
    run_info[:run_start_time] = Time.parse(params[:time])
    run_info[:details] = params[:details]
    run = Run.create_with_creator_and_invitees(
      current_user,
      params[:group_name],
      [params[:friends]],
      run_info
    )

    redirect_to run
  end

  def show
    @run = Run.find_by_id(params[:id])
  end

  def new
    @run = Run.new
    @routes = Route.all
  end

end


