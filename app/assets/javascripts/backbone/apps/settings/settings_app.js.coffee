@RunLine.module "SettingsAppp", (SettingsAppp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    showSettings: ->
      SettingsAppp.Show.Controller.showSettings()

  SettingsAppp.on "start", ->
    API.showSettings()
