@RunLine = do (Backbone, Marionette) ->
  App = new Marionette.Application

  App.addRegions
    headerRegion: "#header-region"
    contentRegion: "#content-region"
    footerRegion: "#footer-region"
    sidebarRegion: "#sidebar-region"

  App.addInitializer ->
    App.module("HeaderApp").start()
    App.module("FooterApp").start()
    App.module("SidebarApp").start()
    # App.module("RunApp").start()
    new App.Router
    Backbone.history.start()

  App

