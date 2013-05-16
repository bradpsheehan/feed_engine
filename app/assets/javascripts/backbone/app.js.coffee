@RunLine = do (Backbone, Marionette) ->
  App = new Marionette.Application

  App.addRegions
    headerRegion: "#header-region"
    footerRegion: "#footer-region"
    sidebarRegion: "#sidebar-region"
    contentRegion: "#content-region"

  App.addInitializer ->
    App.module("HeaderApp").start()
    App.module("FooterApp").start()
    App.module("SidebarApp").start()
    App.module("FeedApp").start()

  App
