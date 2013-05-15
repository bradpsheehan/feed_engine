@RunLine.module "SidebarApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Sidebar extends Marionette.Layout
    template: "sidebar/show/templates/sidebar"
    regions:
      userInfo: "#user-info",


