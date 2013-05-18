class RunLine.Router extends Backbone.Router

  routes:
    "new" : "editRun"


  editRun: ->
    RunLine.RunApp.List.Controller.listRun()

