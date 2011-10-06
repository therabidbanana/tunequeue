App.Views.Settings = Backbone.View.extend
  id: "settings"
  events:
    "submit form": "save"
    "click .remove": "removeGuest"
    "click .add_guest": "addGuest"

  initialize: ->
    $('body').append(this.el)
    this.saved_settings = {}
    self = this
    $.get '/settings', {}, (resp)->
      
      console.log("requesting current settings", resp)
      self.saved_settings = resp
      self.render()

  render: ->
    $(this.el).html(JST['settings'](settings: this.saved_settings))
    
  removeGuest: (e)->
    $(e.target).closest('.guest').remove()
    false
  addGuest: (e)->
    $('#guest_list', this.el).append(JST['partials/guest'](guest_name: ""))
    false

  save: (e)->
    data = $(e.target).serializeArray()
    self = this
    $.post '/settings', $(e.target).serializeArray(), (resp)->
      console.log("Submitted,", data, resp)
      self.saved_settings = resp
      self.render()
      
    return false
