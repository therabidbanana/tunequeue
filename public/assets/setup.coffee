(function() {
  var MusicLibrary;
  MusicLibrary = (function() {
    function MusicLibrary() {}
    MusicLibrary.prototype.tracks = function() {
      return $.getJSON('/library', {}, function(data) {
        return _.each(data.tracks, function(src) {
          var node;
          node = $('<a>').attr('data-url', "http://tunequeue.s3.amazonaws.com/" + src).text(src);
          node.attr('href', '#');
          node.click(function(e) {
            $.ws.send("playSong", {
              url: $(e.target).attr('data-url')
            });
            return false;
          });
          return $('body').append(node);
        });
      });
    };
    return MusicLibrary;
  })();
  $.library = new MusicLibrary;
}).call(this);
(function() {
  jQuery(function($) {
    $('body').empty();
    return $.library.tracks();
  });
  soundManager.url = '/swfs/';
  soundManager.onready(function() {
    return console.log("Sound manager loaded");
  });
}).call(this);
