@RunLine.module "RunApp.List", (List, App, Backbone, Marionette, $, _) ->

  List.Controller =

    listRun: ->
      inputs = App.request "run:entities"
      runView = @getRunView(inputs)
      App.contentRegion.show runView

    getRunView:(inputs) ->
      new List.Runs
        collection: inputs
