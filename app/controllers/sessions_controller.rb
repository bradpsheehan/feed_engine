class SessionsController < ApplicationController
  def create
    runner = User.from_omniauth(env['omniauth.auth'])
    
    if runner
      session[:user_id] = runner.id
      Client::API.get_runs(current_user) if current_user.app_token
      redirect_to profile_path, notice: "Signed in."
    else
      redirect_to root_path, alert: "Authentication failed."
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out."
  end
end
