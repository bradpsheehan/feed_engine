@RunLine.module "SettingsApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Settings extends Marionette.ItemView
    template: "settings/show/templates/settings"
