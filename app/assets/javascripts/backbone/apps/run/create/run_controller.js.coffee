@RunLine.module "RunApp.Create", (Create, App, Backbone, Marionette, $, _) ->

  Create.Controller =

    createRun: ->
      newRun = App.request "run:entities"
      runView = @getCreateRunView(newRun)
      App.contentRegion.show runView

    getCreateRunView:(run) ->
      run = new Create.Run
        model: run
      console.log run.model

      run
