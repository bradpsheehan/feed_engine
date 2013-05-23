class SessionsController < ApplicationController
  def create
    runner = User.from_omniauth(env['omniauth.auth'])

    if runner
      session[:user_id] = runner.id
      begin
        get_user_runs
      rescue
      end
      redirect_to profile_path, notice: "Signed in."
    else
      redirect_to root_path, alert: "Authentication failed."
    end
  end

  def get_user_runs
    #to_do add background worker
    Client::API.get_runs(current_user) if current_user.app_token
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out."
  end
end
