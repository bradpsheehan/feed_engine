class RegistrationsController < ApplicationController

  def create
    Registrar.register(auth: env['omniauth.auth'], user: current_user)
    Client::API.get_runs(current_user)
    redirect_to dashboard_path, notice: "Successfully registered."
  end

end
