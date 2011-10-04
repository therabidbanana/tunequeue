#= require app/music_lib
jQuery ($)->
  $('body').empty()
  $('body').append($('<div id="library">'))
  $('body').append(JST['chat_window']())
  $.library.tracks()
soundManager.url = '/swfs/'
soundManager.onready ()->
  # Good to go.
  console.log("Sound manager loaded")
