App.Views.Settings = Backbone.View.extend
  id: "settings"
  events:
    "submit form": "save"

  initialize: ->
    $('body').append(this.el)
    this.render()

  render: ->
    $(this.el).html(JST['settings']())
    
  save: (e)->
    $.post '/settings', $(e.target).serializeArray(), ()->
      console.log("Submitted")
    return false
