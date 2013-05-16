@RunLine.module "FeedApp", (FeedApp, App, Backbone, Marionette, $, _) ->

  API =
    listFeed: ->
      FeedApp.List.Controller.listFeed()

  FeedApp.on "start", ->
    API.listFeed()

