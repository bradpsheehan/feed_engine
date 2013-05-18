class RunsController < ApplicationController
  def create_run
    Run.create_run("test_run_name", "twitterer,another_twitterer")
    redirect_to "/"
  end
end
