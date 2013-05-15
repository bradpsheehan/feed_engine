@RunLine.module "SidebarApp", (SidebarApp, App, Backboone, Marionette, $, _) ->
  @startWithParent = false

  API =
    showSidebar: ->
      SidebarApp.Show.Controller.showSidebar()

  SidebarApp.on "start", ->
    API.showSidebar()


