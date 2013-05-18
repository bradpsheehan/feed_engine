@RunLine.module "RunApp", (RunApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    listRun: ->
      RunApp.List.Controller.listRun()

  RunApp.on "start", ->
    API.listRun()


