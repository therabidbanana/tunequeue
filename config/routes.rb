# Check out https://github.com/joshbuddy/http_router for more information on HttpRouter
HttpRouter.new do
  add('/').to(HomeAction)
  add('/socket').to(SocketAction)
  add('/library').to(LibraryAction)
  add('/pusher/auth').to(PusherAuthAction)
  add('/auth/:provider/callback').to(OmniauthCallbackAction)
  add('/auth/failure').redirect("/locked.html")
  add('/settings').to(SettingsAction)
  add('/play_next').to(PlayNextAction)
end
