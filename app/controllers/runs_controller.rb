class RunsController < ApplicationController
  def create_run
    Run.create(current_user, "test_run_name", "twitterer,another_twitterer")
    redirect_to "/"
  end
end
