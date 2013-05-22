class UsersController < ApplicationController

  before_filter :check_user_logged_in

  def show
    render 'profile'
  end


end
