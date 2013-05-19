@RunLine.module "HeaderApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  Show.Controller =

    showHeader: ->
      links = App.request "header:entities"
      headerView = @getHeaderView(links)
      App.headerRegion.show headerView

    getHeaderView:(links) ->
      new Show.Headers
        collection: links
