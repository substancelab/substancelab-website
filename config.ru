# frozen_string_literal: true

require "bridgetown-core/rack/boot"

Bridgetown::Rack.boot

# Serve assets from the Vite development server, when it is running
if Bridgetown.env.development?
  require "vite_ruby"
  use ViteRuby::DevServerProxy, ssl_verify_none: true
end

unless defined?(RodaApp)
  class RodaApp < Roda
    plugin :bridgetown_server
    route(&:bridgetown)
  end
end

run RodaApp.freeze.app
