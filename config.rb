puts %q{
   _____  /\ __  ____   _____ _______ ___/\  __ __  _____  _____    _/|    ___/\  ____
  /  ___\/  |  \/  _ \_/  ___V__   __V  _  \/  \  \/  ___\/   __\  /  !___/  _  \/  _ \_
 /____   \  !   \  _   \____  \/   \/       \ \    \      \   ___\/       \      \  _   \
/         \_____/______/______/\___/\___!___/__\_  /______/____  /\_______/__|___/       \
\_________/ substancelab.com                     \/            \/              \_________/

}

LOCALE = ENV["LOCALE"] || I18n.default_locale.to_s

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

# Blogging
activate :blog do |blog|
  blog.permalink = ":title"
  blog.sources = File.join(LOCALE, ":year-:month-:day-:title.html")
  blog.prefix = "articles"
end
page "articles/*", :layout => :articles

# Deployment
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
activate :i18n, :mount_at_root => LOCALE
I18n.locale = LOCALE
require 'lib/i18n_helpers'
helpers I18nHelpers

require 'lib/article_helpers'
helpers ArticleHelpers

require 'lib/asset_helpers'
helpers AssetHelpers

require 'lib/client_helpers'
helpers ClientHelpers

require 'lib/i18n_helpers'
helpers I18nHelpers

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
