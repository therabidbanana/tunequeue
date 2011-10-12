# Global play queue
App.Views.PlayQueue = Backbone.View.extend
  id: "queue"
  events:
    "click .skip": "skip"

  initialize: ->
    $('body').append(this.el)
    this.up_next = {}
    self = this
    $.get '/play_queue', {}, (resp)->
      console.log("requesting current settings", resp)
      self.up_next = resp
      self.render()

  render: ->
    $(this.el).html(JST['play_queue'](up_next: this.up_next))
    
  requestSong: (url)->
    self = this
    $.post '/play_queue', {request_song: url}, (resp)->
      console.log resp
      self.up_next = resp
      self.render()
      
    return false

  playNext: ()->
    self = this
    return unless this.up_next?.song_list?[0]?
    next_url = this.up_next.song_list[0]
    $.post '/play_queue', {play_song: next_url}, (resp)->
      self.up_next = resp if resp?
      self.render()
      
    return false
  
  skip: ()->
    soundManager.stop('playing')
