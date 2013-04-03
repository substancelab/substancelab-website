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
LOCALE = ENV["LOCALE"]
if LOCALE
  # Deploy to UnoEuro
  DEPLOYMENT_PATHS = {
    'da' => "/public_html/",
    'en' => "/substancelab.com/"
  }
  activate :deploy do |deploy|
    deploy.method = :ftp
    deploy.user = "substancelab.dk"
    deploy.host = "linux41.unoeuro.com"
    deploy.path = DEPLOYMENT_PATHS[LOCALE]
    deploy.password = "jQBhDPEKAkzxa8jpjarJHTGZna4sdKLUMyGPNEiiKQtLTgcvZT"
  end
end

# Pretty URLs
activate :directory_indexes

# Hello World
activate :i18n, :mount_at_root => ENV["LOCALE"] || :en
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

# Build-specific configuration
configure :build do
  # Minify all the things
  activate :minify_css
  activate :minify_html
  activate :minify_javascript
end
