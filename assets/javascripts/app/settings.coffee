$ ()-> 
  $('#settings').submit ()->
    console.log("Submitting")
    $.post '/settings', $('#settings').serializeArray(), ()->
      console.log("Submitted")
    return false
