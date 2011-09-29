class MusicLibrary
  tracks: ->
    $.getJSON '/library', {}, (data)->
      _.each data.tracks, (src)->
        node = $('<a>').attr('data-url', "http://tunequeue.s3.amazonaws.com/"+src).text(src)
        node.attr('href', '#')
        node.click (e)->
          # $.ws.send("playSong", {url: $(e.target).attr('data-url')})
          # return false
        $('body').append(node)

$.library = new MusicLibrary
