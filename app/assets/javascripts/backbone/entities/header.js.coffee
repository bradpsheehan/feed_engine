@RunLine.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Header extends Backbone.Model

  class Entities.HeaderCollection extends Backbone.Collection
    model: Entities.Header

  API =
    getHeaders: ->
      console.log "WUD UP!"

      new Entities.HeaderCollection [
        { name: "Bradley's Account" }
        { name: "Logout" }
      ]

  App.reqres.setHandler "header:entities", ->
    API.getHeaders()
