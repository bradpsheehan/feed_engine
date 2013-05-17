@RunLine.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Feed extends Backbone.Model
    initialize: ->
      console.log "wooooooo"
      @userPhoto = "huzaaahh"

  class Entities.Feeds extends Backbone.Collection
    model: Entities.Feed
