class MusicLibrary
  tracks: ->
    $.getJSON '/library', {}, (data)->
      _.each data.tracks, (src)->
        node = $('<a>').attr('data-url', src.url).text(src.filename)
        node.attr('href', '#')
        node.click (e)->
          $.ws.trigger("client-play", {url: $(e.target).attr('data-url')})
          soundManager.unload('playing')
          soundManager.play('playing', {url: $(e.target).attr('data-url')})
          return false
        $('body').append(node)

$.library = new MusicLibrary
