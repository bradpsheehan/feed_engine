@RunLine.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Run extends Backbone.Model
    _route = null

    getRoute = ->
      new Entities.Route({id: @routeId})

    constructor:(attributes, options) ->
      @groupName = attributes.group_name
      @date = attributes.date
      @time = attributes.time
      @runners = new Entities.Users(attributes.runners)
      @routeId = parseInt(attributes.routeId)


    route:
      _route ||= getRoute()


  class Entities.Runs extends Backbone.Collection
    model: Entities.Run


