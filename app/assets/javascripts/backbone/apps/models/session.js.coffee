@RunLine.Session = Backbone.Model.extend
  defaults:
    access_token: null,
    user_id: null

  initialize: ->
    console.log "initializing"
    @load()

  authenticated: ->
    Boolean(@get("_feed_engine_session"))

  save: (auth_hash)->
    #$.cookie('user_id', auth_hash.id)
    $.cookie('_feed_engine_session', auth_hash.access_token)

  load: ->
    @set
      #user_id: $.cookie('user_id')
      access_token: $.cookie('_feed_engine_session')
