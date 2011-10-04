class ChatWindow
  prepare: ->
    $.ws.bind 'pusher:subscription_succeeded', (members)->
      return false
    this.render()
  render: ->
    JST['chat_window']()
  chat: (data)->
    JST['chat_bubble']({chat: data})
  send: ()->
    message = $('#chat-input').empty()
    $.ws.trigger('client-chat', {})
    $('#chat-input').empty()
