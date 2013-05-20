class RegistrationsController < ApplicationController

  def create
    Registrar.register(auth: env['omniauth.auth'], user: current_user)
    redirect_to new_run_path, notice: "Successfully registered."
  end

end
