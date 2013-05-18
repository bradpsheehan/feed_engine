@RunLine.module "RunApp", (RunApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    listRun: ->
      RunApp.Show.Controller.showRun()

  RunApp.on "start", ->
    API.listRun()


