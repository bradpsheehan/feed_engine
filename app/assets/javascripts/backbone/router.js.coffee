class RunLine.Router extends Backbone.Router

  routes:
    "new" : "editRun"
    "settings" : "editSettings"


  editRun: ->
    RunLine.RunApp.Create.Controller.createRun()

  editSettings: ->
    RunLine.SettingsApp.Show.Controller.showSettings()

