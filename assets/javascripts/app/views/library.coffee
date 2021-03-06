App.Views.Library = Backbone.View.extend
  id: "library"
  initialize: ->
    $('body').append(this.el)
    this.getTracks()
    this.queue = new App.Views.PlayQueue()

  getTracks: ->
    self = this
    $.getJSON '/library', {}, (data)->
      self.tracks = data.tracks
      self.render()
  playNext: ->
    this.queue.playNext()
    false
  render: ->
    library = this
    _.each this.tracks, (src)->
      console.log(src)
      node = JST['partials/song']({song:src})
      node = $(node)
      node.click (e)->
        # $.ws.trigger("client-play", {url: $(e.target).attr('data-url')})
        # soundManager.unload('playing')
        # soundManager.play('playing', {url: $(e.target).attr('data-url')})
        library.queue.requestSong($(e.target).attr('data-url'))
        return false
      $(library.el).append(node)
