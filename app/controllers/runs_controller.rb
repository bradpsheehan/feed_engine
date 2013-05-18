class RunsController < ApplicationController
  respond_to :json

  def create
    # run = Run.create_run("test_run_name", "twitterer,another_twitterer")
    run = Run.new
    run.name = params[:group_name]
    run.save!

    respond_with(run)
  end

end
