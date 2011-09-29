require "rubygems"
require "bundler/setup"
require 'yaml'
# Bundler.setup

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

    def self.config
      @_config ||= YAML::load( File.read( './config/settings.yml' ) )
      @_config[env]
    end

    def self.pusher!
      Pusher.app_id = config['pusher']['app_id']
      Pusher.key = config['pusher']['auth_key']
      Pusher.secret = config['pusher']['auth_secret']
    end

    # Initialize the application
    def self.initialize!
      pusher!
      
      unless Tunequeue::Application.env == "production"
        assets.prepend_path(File.join(root, 'assets', 'javascripts'))
        assets.prepend_path(File.join(root, 'assets', 'stylesheets'))
        assets.prepend_path(File.join(root, 'assets', 'templates'))
        assets.register_engine '.jade', ::TiltJade::Template
      end
    end

  end
end

Bundler.require(:default, Tunequeue::Application.env)

# Preload application classes
Dir['./app/**/*.rb'].each {|f| require f}
