@RunLine.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Route extends Backbone.Model
    constructor:(attributes, options) ->
      @id = parseInt(attributes.id)
      @points = new Entities.Points(attributes.points)
