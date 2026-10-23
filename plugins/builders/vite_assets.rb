# frozen_string_literal: true

require "vite_ruby"

# Builds stale Vite assets in development before Bridgetown reads the source
# directory, so they are copied to the output with the other static files.
#
# This replaces ViteRuby's autoBuild, which builds when the helpers look up
# assets. That is too late for the assets to be copied, and checks whether
# assets are stale on every lookup.
#
# Production builds run `rake vite:build` before building the site.
class Builders::ViteAssets < SiteBuilder
  def build
    hook :site, :pre_read do
      next unless Bridgetown.env.development?

      vite = ViteRuby.instance
      next if vite.dev_server_running?

      vite.builder.build
    end
  end
end
