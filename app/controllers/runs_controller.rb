class RunsController < ApplicationController
  respond_to :json

  def create
    run = Run.new
    run.name = params[:group_name]
    run.save!

    respond_with(run)

  end

end
