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

require "sassy-math"

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

require 'lib/html_helpers'
helpers HtmlHelpers

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
  activate :favicon_maker, :icons => {
    "favicon_template.png" =>   [
      { icon: "apple-touch-icon-152x152-precomposed.png" },
      { icon: "apple-touch-icon-144x144-precomposed.png" },
      { icon: "apple-touch-icon-114x114-precomposed.png" },
      { icon: "apple-touch-icon-72x72-precomposed.png" },
      { icon: "apple-touch-icon-precomposed.png", size: "57x57" },
      { icon: "apple-touch-icon.png", size: "57x57" },
      { icon: "favicon.png", size: "16x16" },
      { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" },
      { icon: "mstile-144x144", format: "png" },
    ]
  }

  # Minify all the things
  activate :minify_css
  activate :minify_html
  activate :minify_javascript
end
