@RunLine.module "FeedApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Feeds extends Marionette.ItemView
    template: "feed/list/templates/feeds"
