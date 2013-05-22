class RegistrationsController < ApplicationController

  def create
    success = Registrar.register(auth: env['omniauth.auth'], user: current_user)

    if success
      redirect_to new_run_path, notice: "Successfully registered."
    else
      flash[:error] = "Registration failed."
      render 'users/profile'
    end
  end

  def destroy
    current_user.app_provider.destroy
    redirect_to '/profile', notice: "App Successfully Disconnected"
  end

end
