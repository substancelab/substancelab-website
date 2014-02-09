LOCALE = ENV["LOCALE"] || 'en'

# Configure site
SETTINGS = {
  "da" => {
    "deploy_path" => "/public_html/",
    "domain" => "substancelab.dk"
  },
  "en" => {
    "deploy_path" => "/substancelab.com/",
    "domain" => "substancelab.com"
  }
}
SITE_SETTINGS = SETTINGS[LOCALE]
# Expose configuration to the entire Middleman application
SITE_SETTINGS.each do |key, value|
  self.set(key.intern, value)
end

require 'slim'
Slim::Engine.set_default_options({
  :format => :html5,
  :pretty => true
})

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

# Add asset hash to URLs
activate :asset_hash

# Deployment
activate :deploy do |deploy|
  deploy.method = :ftp
  deploy.user = "substancelab.dk"
  deploy.host = "linux41.unoeuro.com"
  deploy.path = self.deploy_path
  deploy.password = "jQBhDPEKAkzxa8jpjarJHTGZna4sdKLUMyGPNEiiKQtLTgcvZT"
end

# Pretty URLs
activate :directory_indexes

# Hello World
activate :i18n, :mount_at_root => LOCALE
require 'lib/i18n_helpers'
helpers I18nHelpers

require 'lib/asset_helpers'
helpers AssetHelpers

require 'lib/client_helpers'
helpers ClientHelpers

require 'lib/layout_helpers'
helpers LayoutHelpers

require 'lib/project_helpers'
helpers ProjectHelpers

case_studies.each do |case_study|
  proxy File.join("/work", case_study.slug, "index.html"), "/work/case_study.html", :locals => {:project => case_study}, :ignore => true
end

# Sitemapping
require 'builder'
page "/sitemap.xml", :layout => false


# Build-specific configuration
configure :build do
  # Minify all the things
  activate :minify_css
  activate :minify_html
  activate :minify_javascript
end
