@RunLine.module "SidebarApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  Show.Controller =
    showSidebar: ->
      sidebarView = @getSidebarView()
      App.sidebarRegion.show sidebarView

    getSidebarView: ->
      new Show.Sidebar

