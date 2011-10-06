# Global play queue
App.Views.PlayNext = Backbone.View.extend
  id: "queue"
  # events:
  #   "click .remove": "removeSong"

  initialize: ->
    $('body').append(this.el)
    this.up_next = {}
    self = this
    $.get '/play_next', {}, (resp)->
      console.log("requesting current settings", resp)
      self.up_next = resp
      self.render()

  render: ->
    $(this.el).html(JST['play_next'](up_next: this.up_next))
    
  requestSong: (url)->
    self = this
    $.post '/play_next', {request_song: url}, (resp)->
      console.log resp
      self.up_next = resp
      self.render()
      
    return false

