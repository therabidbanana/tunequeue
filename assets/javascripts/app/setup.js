//= require_self
//= require_tree ./views
//= require_tree ./models
var App = {
  Views: {},
  Controllers: {},
  Models: {},
  Collections: {},
  Routers: {},
  Player: null,
  init: function(){
    //# Backbone.history.start({pushState: true, silent: true});
    Tunequeue = new App.Views.Tunequeue();
    false
  }

}

var Tunequeue;

jQuery(function($){
  App.init()
  setInterval(function(){
    Tunequeue.heartbeat();
  }, 1500)
})

