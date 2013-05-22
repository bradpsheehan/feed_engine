class RegistrationsController < ApplicationController

  def create
    success = Registrar.register(auth: env['omniauth.auth'], user: current_user)

    if success
      redirect_to new_run_path, notice: "Successfully registered."
    else
      flash[:error] = "Error"
      render 'users/profile'
    end
  end

end
