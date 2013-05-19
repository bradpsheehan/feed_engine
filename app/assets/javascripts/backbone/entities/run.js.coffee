@RunLine.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Run extends Backbone.Model
    _route = null

    urlRoot: "/runs"

    getRoute = ->
      new Entities.Route({id: @routeId})

    defaults:
      groupName: "Unnamed"
      date: null
      time: null
      runners: []
      routeId: null

    route:
      _route ||= getRoute()

  class Entities.Runs extends Backbone.Collection
    model: Entities.Run

    url: "/runs"

  API =
    getRuns: ->
      console.log "need to get user runs"

  App.reqres.setHandler "run:entities", ->
    API.getRuns()
