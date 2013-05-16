@RunLine.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Header extends Backbone.Model

  class Entities.HeaderCollection extends Backbone.Collection
    model: Entities.Header

  API =
    getHeaders: ->
      new Entities.HeaderCollection([
        {
          name: @getCurrentUser()
          url: '/#dashboard'
          id: "blah"
        }
        {
          name: "Logout"
          url: '/signout'
        }
      ])

    getCurrentUser: ->
      name = "test"
      console.log "1"
      $.get '/user',
        (userInfo) ->
          console.log "2"
          name = userInfo['name']
          $('#blah').html(name)
      console.log "3"
      name

      
      
      # userInfo = eval($.get('/user'))
      # userInfo['name']
      # console.log userInfo


  App.reqres.setHandler "header:entities", ->
    API.getHeaders()
