@RunLine.module "RunApp", (RunApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    createRun: ->
      RunApp.Create.Controller.createRun()

  RunApp.on "start", ->
    API.createRun()


