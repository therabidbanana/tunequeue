# Raw websocket
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
#
jQuery.pusher = pusher = new Pusher('f105fd947e7536085297')
jQuery.ws = ws = pusher.subscribe('presence-room')
ws.bind('client-play', (data)->
  console.log("User requested playing", data.url)
  soundManager.unload('playing')
  soundManager.play('playing', {url: data.url})
)
ws.bind('client-somebody-playing', (data)->
  console.log("User wants to know if something is playing")
)
ws.bind('play-song', (data)->
  console.log("User requested playing", data.url)
  soundManager.unload('playing')
  soundManager.play('playing', {url: data.url})
)
