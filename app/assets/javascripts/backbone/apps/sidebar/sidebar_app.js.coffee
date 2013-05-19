@RunLine.module "SidebarApp", (SidebarApp, App, Backboone, Marionette, $, _) ->
  @startWithParent = false

  API =
    listSidebar: ->
      SidebarApp.List.Controller.listSidebar()

  SidebarApp.on "start", ->
    API.listSidebar()

