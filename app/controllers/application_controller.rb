class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :json, only: :request_user

  before_filter :check_user_logged_in, only: :index

  def landing_page
    if current_user
      redirect_to dashboard_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def check_user_logged_in
    unless current_user
      redirect_to root_path
    end
  end

end

