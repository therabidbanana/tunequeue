App.Views.Tunequeue = Backbone.View.extend
  id: "tunequeue"

  initialize: ->
    $('body').empty()
    $('body').append(this.el)
    soundManager.url = '/swfs/';
    soundManager.onready ()->
      console.log("Sound manager loaded")
    $('body').append(JST['chat_window']())
    this.settingsView = new App.Views.Settings()
    $.library.tracks()
    this.render()

  render: ->
    $(this.el).html(JST['tunequeue']())
    
  save: (e)->
    $.post '/settings', $(e.target).serializeArray(), ()->
      console.log("Submitted")
    return false

