class SessionsController < ApplicationController
  def create
    runner = User.from_omniauth(env['omniauth.auth'])
    if runner
      session[:user_id] = runner.id
      redirect_to dashboard_path, notice: "Signed in."
    else
      redirect_to dashboard_path, alert: "Authentication failed."
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out."
  end
end
