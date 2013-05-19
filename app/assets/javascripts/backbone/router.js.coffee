class RunLine.Router extends Backbone.Router

  routes:
    "new" : "editRun"
    "settings" : "editSettings"


  editRun: ->
    RunLine.RunApp.List.Controller.listRun()

  editSettings: ->
    RunLine.SettingsApp.Show.Controller.showSettings()

