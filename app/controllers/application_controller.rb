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

  def post_to_twitter
    current_user.twitter.update("Tweetie2 from Twweeter.")
    redirect_to "/"
  end

  def request_user
    respond_with(current_user)
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end

