class ActivitiesController < ApplicationController

  def show
    @activity = Activity.find(params[:id])
    path = @activity.run_detail["path"]
    gon.path = path
  end

end
