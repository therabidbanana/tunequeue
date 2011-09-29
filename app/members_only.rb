class MembersOnly
  def initialize(app, options = {})
    options['whitelist'] ||= [%r|^/locked|, %r|/auth|, %r|/assets|, %r|/favicon|]
    @options = options
    @app = app
  end

  def call(env)
    puts env['rack.session'].inspect
    return @app.call(env) if outside?(env["PATH_INFO"])
    return @app.call(env) if on_the_list?(env['rack.session']['oa-provider'], env['rack.session']['oa-uid'])
    return [301, {"Location" => "/locked.html"}, [""]]
  end
  def outside?(path)
    @options['whitelist'].any?{ |foo| path.match(foo)}
  end
  def on_the_list?(provider, uid)
    Tunequeue::Application.config['admins'][provider].include?(uid)
  end
end
