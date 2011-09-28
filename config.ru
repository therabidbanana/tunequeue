require './application'
Tunequeue::Application.initialize!

# Development middlewares
if Tunequeue::Application.env == 'development'
  use AsyncRack::CommonLogger

  # Enable code reloading on every request
  use Rack::Reloader, 0

  # Serve assets from /public
  use Rack::Static, :urls => ["/index.html", "/swfs"], :root => Tunequeue::Application.root(:public)
end

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
