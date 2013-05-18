@RunLine.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.User extends Backbone.Model
    constructor: (attributes, options)->
      @name = attributes.name
      @runs = @initializeRuns(attributes.runs)
      @imageURL = attributes.imageURL

    initializeRuns:(runs) ->
      new Entities.Runs(runs)

  class Entities.Users extends Backbone.Model
    model: Entities.User
