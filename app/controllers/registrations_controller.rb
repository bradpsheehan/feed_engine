class RegistrationsController < ApplicationController

  def create
    Registrar.register(auth: env['omniauth.auth'], user: current_user)
    Client::API.get_runs(current_user)
    success = Registrar.register(auth: env['omniauth.auth'], user: current_user)

    if success
      redirect_to new_run_path, notice: "Successfully registered."
    else
      flash[:error] = "There was an issue processing your request, please try again"
      render 'users/profile'
    end
  end

  def dailymile_connect
    binding.pry
  end


end
