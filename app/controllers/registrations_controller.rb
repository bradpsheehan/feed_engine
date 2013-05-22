class RegistrationsController < ApplicationController

  def create
    success = Registrar.register(auth: env['omniauth.auth'], user: current_user)
    Client::API.get_runs(current_user)

    if success
      redirect_to new_run_path, notice: "Successfully registered."
    else
      flash[:error] = "There was an issue processing your request, please try again"
      render 'users/profile'
    end
  end

  def new
  end

  def dm_connect
    provider = AppProvider.new(name: params[:provider],
                               username: params[:dm_username],
                               user_id: current_user.id)

    if provider.save
      Dailymile::Activities.new.for_user(current_user.username)
      redirect_to new_run_path, notice: "Successfully registered."
    else
      flash[:error] = "There was an issue processing your request, please try again"
      render 'users/profile'
    end
  end


end
