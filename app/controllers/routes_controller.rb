class RoutesController < ApplicationController

  respond_to :json

  def create
    @route = Route.create(name: params[:name], path: params[:path])
    respond_with(@route)
  end

  def show
    @route = Route.find_by_id(params[:id])
    respond_with(@route)
  end

  def index
    @routes = Route.all
    respond_with(@routes)
  end

  def update

  end
end
