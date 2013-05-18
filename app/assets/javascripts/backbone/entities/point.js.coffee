@RunLine.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Point extends Backbone.Model
    constructor:(attributes, options) ->
      @longitude = attributes.longitude
      @latitude = attributes.latitiude

  class Entities.Points extends Backbone.Collection
    model: Entities.Point
