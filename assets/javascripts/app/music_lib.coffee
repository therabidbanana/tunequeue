class MusicLibrary
  tracks: ->
    $.getJSON '/library', {}, (data)->
      _.each data.tracks, (src)->
        node = JST['song']({song:src})
        node = $(node)
        node.click (e)->
          $.ws.trigger("client-play", {url: $(e.target).attr('data-url')})
          soundManager.unload('playing')
          soundManager.play('playing', {url: $(e.target).attr('data-url')})
          return false
        $('body #library').append(node)

$.library = new MusicLibrary
