@RunLine.module "RunApp.Create", (Create, App, Backbone, Marionette, $, _) ->

  class Create.Run extends Marionette.ItemView
    template: "run/create/templates/run"

    events: ->
      "submit form" : "createRun"

    createRun:(event) ->
      runDetails = $(event.currentTarget).serializeObject()
      run = new App.Entities.Run
      run.save(runDetails,
        success: ->
          console.log "HEY HYE HEY"
        error: ->
          console.log "boohooo"
      )

      false
