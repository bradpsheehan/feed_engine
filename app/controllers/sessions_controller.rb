class SessionsController < ApplicationController
  def create
    if current_user
      Registrar.register(auth: env['omniauth.auth'], user: current_user)
    else
      runner = User.from_omniauth(env['omniauth.auth'])
      session[:user_id] = runner.id
      cookies[:thesesh] = "woohoo"
      redirect_to dashboard_path, notice: "Signed in."
      return
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out."
  end
end
