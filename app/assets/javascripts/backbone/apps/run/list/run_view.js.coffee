@RunLine.module "RunApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Run extends Marionette.ItemView
    template: "run/list/templates/_run"

  class List.Runs extends Marionette.CompositeView
    template: "run/list/templates/runs"
    itemView: List.Run
    itemViewContainer: "#run_data"

    events: ->
      "submit form" : "createRun"

      

    createRun: ->
      value = $("#group_name").val()
      $.post "/runs",
        group_name: value
      , (run) ->

      false
