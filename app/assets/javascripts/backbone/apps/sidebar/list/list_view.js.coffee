@RunLine.module "SidebarApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Sidebar extends Marionette.ItemView
    template: "sidebar/list/templates/_sidebar"
    tagName: "li"

  class List.Sidebars extends Marionette.CompositeView
    template: "sidebar/list/templates/sidebars"
    itemView: List.Sidebar
    itemViewContainer: "ul"
