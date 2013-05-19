@RunLine = do (Backbone, Marionette) ->
  App = new Marionette.Application

  App.addRegions
    headerRegion: "#header-region"
    contentRegion: "#content-region"
    footerRegion: "#footer-region"
    sidebarRegion: "#sidebar-region"
    contentRegion: "#content-region"

  App.addInitializer ->
    App.module("HeaderApp").start()
    App.module("FooterApp").start()
    App.module("SidebarApp").start()
    new App.Router
    Backbone.history.start()

  App

