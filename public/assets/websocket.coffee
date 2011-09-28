(function() {
  jQuery.ws = jQuery.websocket("ws://" + window.location.host + "/socket", {
    open: function() {
      console.log("Look! I'm online");
      return $.ws.send('announce', {
        username: "me"
      });
    },
    close: function() {
      return console.log("Lost connection");
    },
    events: {
      announce: function(e) {
        return console.log("User joined:", e.data.username);
      },
      playSong: function(e) {
        console.log("User requested playing", e.data.url);
        soundManager.unload('playing');
        return soundManager.play('playing', {
          url: e.data.url
        });
      }
    }
  });
}).call(this);
