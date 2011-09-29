require './application'
Tunequeue::Application.initialize!

# Development middlewares
if Tunequeue::Application.env == 'development'
  use AsyncRack::CommonLogger

  # Enable code reloading on every request
  use Rack::Reloader, 0

  # Serve assets from /public
  use Rack::Static, :urls => ["/index.html", "/swfs", "/favicon.ico", "/locked.html"], :root => Tunequeue::Application.root(:public)
end
if Tunequeue::Application.env == 'production'
  use Rack::Static, :urls => ["/index.html", "/swfs", "/assets", '/favicon.ico', '/locked.html'], :root => Tunequeue::Application.root(:public)
end

use Rack::Session::Cookie, :key => 'rack.session',
                               :domain => 'tunequeue.dev',
                               :path => '/',
                               :expire_after => 2592000,
                               :secret => 'change_me'

use OmniAuth::Strategies::Twitter, Tunequeue::Application.config['twitter']['key'], Tunequeue::Application.config['twitter']['secret']
use MembersOnly


map("/assets") do
  run Tunequeue::Application.assets
end

# Running thin :
#
#   bundle exec thin --max-persistent-conns 1024 --timeout 0 -R config.ru start
#
# Vebose mode :
#
#   Very useful when you want to view all the data being sent/received by thin
#
#   bundle exec thin --max-persistent-conns 1024 --timeout 0 -V -R config.ru start
#
map("/") do
  run Tunequeue::Application.routes
end
