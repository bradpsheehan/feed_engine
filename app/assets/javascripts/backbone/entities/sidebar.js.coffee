@RunLine.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Sidebar extends Backbone.Model

  class Entities.SidebarCollection extends Backbone.Collection
    model: Entities.Sidebar

  API =
    getSidebars: ->
      new Entities.SidebarCollection([
        { name: "Your Activity" }
        { name: "FitFeed" }
        { name: "Group Runs" }
      ])


  App.reqres.setHandler "sidebar:entities", ->
    API.getSidebars()
