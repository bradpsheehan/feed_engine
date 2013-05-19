@RunLine.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Sidebar extends Backbone.Model

  class Entities.SidebarCollection extends Backbone.Collection
    model: Entities.Sidebar

  API =
    getSidebars: ->
      new Entities.SidebarCollection([
        {
          name: "MyActivity"
        }
        {
          name: "GroupRuns"
          url: "#/new"
        }
        {
          name: "FitFeed"
        }
        {
          name: "Settings"
          url: "#/settings"
        }
      ])


  App.reqres.setHandler "sidebar:entities", ->
    API.getSidebars()
