@RunLine.module "FeedApp.List", (List, App, Backbone, Marionette, $, _) ->

  List.Controller =

    getFeedItems: ->
      console.log "getting feed items"

    getFeedView: (feedItems) ->
      new List.Feeds

    listFeed: ->
      console.log "tada"
      feedItems = @getFeedItems()
      feedView = @getFeedView(feedItems)
      App.contentRegion.show feedView






