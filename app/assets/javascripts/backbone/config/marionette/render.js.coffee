Backbone.Marionette.Renderer.render = (template, data) ->
 path = JST["backbone/apps/" + template]
 unless path
   throw "Templates #{templates} not found!"
 path(data)
