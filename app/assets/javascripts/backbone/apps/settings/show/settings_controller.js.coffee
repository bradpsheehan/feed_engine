@RunLine.module "SettingsApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  Show.Controller =
    showSettings: ->
      settingsView = @getSettingsView()
      App.contentRegion.show settingsView

    getSettingsView: ->
      new Show.Settings
