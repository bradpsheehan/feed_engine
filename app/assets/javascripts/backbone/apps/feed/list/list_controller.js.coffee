@RunLine.module "FeedApp.List", (List, App, Backbone, Marionette, $, _) ->

  List.Controller =

    getFeedItems: ->
      console.log "getting feed items"
      new App.Entities.Feed

    getFeedView: (feedItems) ->
      console.log feedItems.userPhoto
      new List.Feed
        model: feedItems

    listFeed: ->
      console.log "listing the feed"
      feedItems = @getFeedItems()
      feedView = @getFeedView(feedItems)
      App.contentRegion.show feedView






