@RunLine.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Run extends Backbone.Model

  class Entities.RunCollection extends Backbone.Collection
    model: Entities.Run

  API =
    getRuns: ->
      new Entities.RunCollection([
        {
          label_name: "GroupName"
          name: "group_name"
        }
        {
          label_name: "Date"
          name: "date"
        }
        {
          label_name: "Time"
          name: "time"
        }
        {
          label_name: "Friends"
          name: "friends"
        }
        {
          label_name: "Route"
          name: "route"
        }
        {
          label_name: "Details"
          name: "details"
        }
      ])


  App.reqres.setHandler "run:entities", ->
    API.getRuns()
