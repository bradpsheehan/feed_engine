class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :json, only: :request_user

  def index
  end

  def landing_page
    if current_user
      #@friends = current_user.friends
    end
  end

  def request_user
    respond_with(current_user)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def create_route
    render :new

  end

  # helper_method :current_user
end

