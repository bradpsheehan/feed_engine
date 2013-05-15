@RunLine.module "HeaderApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Header extends Marionette.ItemView
    template: "header/show/templates/_show_header"
    tagName: "li"

  class Show.Headers extends Marionette.CompositeView
    template: "header/show/templates/show_headers"
    itemView: Show.Header
    itemViewContainer: "ul"
