//= require './setup'
var me = "therabidbanana";

$().ready(function(){
  $.ws.bind('pusher:subscription_succeeded', function(members){
    $('#presence').empty()

    members.each(add_member);

    console.log("Count", members.count)
  })

  $.ws.bind('pusher:member_removed', function(member){
    $('#presence_' + member.id).remove();
    console.log("Count", $.ws.members.count)
  })

  $.ws.bind('pusher:member_added', function(member){
    add_member(member)
    console.log("Count", $.ws.members.count)
  })

  $("#message").submit(function() {
    text = $(this).find("input[name=text]").val()
    $.ws.trigger('client-message', {
      text: text,
      user_id: me,
    })
    speak(me, text)
    stop_typing(me)
    this.reset()
    return false
  })

  $.ws.bind("client-message", function(data) {
    speak(data.user_id, data.text)
  })
  
  // var typing = false;
  var typing;
  
  $("#message input[name=text]").keydown(function() {
    if (typing) {
      clearInterval(typing)
    } else {
      start_typing(me)
      $.ws.trigger('client-starttyping', {user_id: me})
    }

    typing = setTimeout(function() {
      stop_typing(me)
      $.ws.trigger('client-stoptyping', {user_id: me})
      clearInterval(typing)
      typing = null
    }, 1200)
  })
  
  $.ws.bind('client-starttyping', function(data) {
    start_typing(data.user_id)
  })
  
  $.ws.bind('client-stoptyping', function(data) {
    stop_typing(data.user_id)
  })
});

function add_member(member) {
  var content
  var rand = rand = (Math.random() * 20) - 10
  var container = $("<div>", {
    "class": "member",
    id: "presence_" + member.id
  }).css({
  })

  content = null

  if (member.id == me) container.addClass("me")

  $('#presence').append(container.html(member.id))
}

function speak(user_id, text) {
  console.log("User", user_id, "says", text)
  var user = $("#chat_log")
  var bubble = $("<div>", {
    "class": "bubble",
    text: user_id+": " + text,
    "style": "display:none;"
  })

  user.append(bubble)

  bubble.fadeIn()
}

var animations = {}
var animation_counters = {}

function start_typing(user_id) {
  $("#presence_" + user_id).addClass("typing")
  
}

function stop_typing(user_id) {
  $("#presence_" + user_id).removeClass("typing")
  
}

