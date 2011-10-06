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
    this.libraryView = new App.Views.Library()
    this.render()

  render: ->
    $(this.el).html(JST['tunequeue']())
    
