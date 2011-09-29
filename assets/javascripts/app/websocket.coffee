# jQuery.ws = jQuery.websocket "ws://#{window.location.host}/socket", 
#   open: () ->
#     console.log("Look! I'm online")
#     $.ws.send('announce', {username: "me"})
#   close: () ->
#     console.log("Lost connection")
#   events: 
#     announce: (e) ->
#       console.log("User joined:", e.data.username)
#     playSong: (e) ->
#       console.log("User requested playing", e.data.url)
#       soundManager.unload('playing')
#       soundManager.play('playing', {url: e.data.url})
