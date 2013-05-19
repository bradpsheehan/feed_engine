@RunLine.module "RunApp.Create", (Create, App, Backbone, Marionette, $, _) ->

  Create.Controller =

    createRun: ->
      runView = @getCreateRunView()
      App.contentRegion.show runView

    getCreateRunView: ->
      new Create.Run
