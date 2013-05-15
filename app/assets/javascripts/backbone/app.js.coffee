@RunLine = do (Backbone, Marionette) ->
  App = new Marionette.Application

  App.addRegions
    headerRegion: "#header-region"

  App.addInitializer ->
    App.module("HeaderApp").start()

  App
