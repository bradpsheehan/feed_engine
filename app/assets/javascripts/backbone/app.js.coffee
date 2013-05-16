@RunLine = do (Backbone, Marionette) ->
  App = new Marionette.Application

  App.addRegions
    headerRegion: "#header-region"
    footerRegion: "#footer-region"
    sidebarRegion: "#sidebar-region"

  App.addInitializer ->
    # App.session = new App.Session()
    # if @session.authenticated()
    #   console.log 'logged in'
    # else
    #   console.log 'not logged in'

    App.module("HeaderApp").start()
    App.module("FooterApp").start()
    App.module("SidebarApp").start()

  App
