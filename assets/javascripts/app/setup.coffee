#= require app/music_lib
jQuery ($)->
  $('body').empty()
  $.library.tracks()
soundManager.url = '/swfs/'
soundManager.onready ()->
  # Good to go.
  console.log("Sound manager loaded")
