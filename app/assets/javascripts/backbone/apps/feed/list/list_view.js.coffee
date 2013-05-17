@RunLine.module "FeedApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Feed extends Marionette.ItemView
    template: "feed/list/templates/feed"

  class List.Feeds extends Marionette.CompositeView
    template: "feed/list/templates/feeds"
    itemView: List.Feed
    itemViewContainer: "ul"
