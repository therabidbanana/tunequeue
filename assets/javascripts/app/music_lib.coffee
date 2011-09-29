class MusicLibrary
  tracks: ->
    $.getJSON '/library', {}, (data)->
      _.each data.tracks, (src)->
        node = $('<a>').attr('data-url', "http://tunequeue.s3.amazonaws.com/"+src).text(src)
        node.attr('href', '#')
        node.click (e)->
          $.ws.trigger("client-play", {url: $(e.target).attr('data-url')})
          soundManager.unload('playing')
          soundManager.play('playing', {url: e.data.url})
          return false
        $('body').append(node)

$.library = new MusicLibrary
