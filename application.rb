require "rubygems"
require "bundler"
Bundler.require(:default)

module Tunequeue
  class Application

    def self.root(path = nil)
      @_root ||= File.expand_path(File.dirname(__FILE__))
      path ? File.join(@_root, path.to_s) : @_root
    end

    def self.assets
      @_assets ||= Sprockets::Environment.new(root) 
    end

    def self.hydra
      @_hydra ||= Typhoeus::Hydra.new
    end

    def self.env
      @_env ||= ENV['RACK_ENV'] || 'development'
    end

    def self.routes
      @_routes ||= eval(File.read('./config/routes.rb'))
    end

    # Initialize the application
    def self.initialize!
      assets.prepend_path(File.join(root, 'assets', 'javascripts'))
      assets.prepend_path(File.join(root, 'assets', 'stylesheets'))
      assets.prepend_path(File.join(root, 'assets', 'templates'))
      assets.register_engine '.jade', ::TiltJade::Template
    end

  end
end

Bundler.require(:default, Tunequeue::Application.env)

# Preload application classes
Dir['./app/**/*.rb'].each {|f| require f}
