# frozen_string_literal: true

LOCALE = ENV["LOCALE"] || I18n.default_locale.to_s

# Configure site
SETTINGS = {
  "da" => {
    "domain" => "substancelab.dk",
    "protocol" => "https://"
  },
  "en" => {
    "domain" => "substancelab.com",
    "protocol" => "https://"
  }
}.freeze
SITE_SETTINGS = SETTINGS.fetch(LOCALE)
# Expose configuration to the entire Middleman application
SITE_SETTINGS.each do |key, value|
  set(key.intern, value)
end

require "slim"
Slim::Engine.set_options(
  :format => :html,
  :pretty => true
)

set :css_dir, "stylesheets"
set :js_dir, "javascripts"
set :images_dir, "images"

# Add asset hash to URLs
activate :asset_hash

# Blogging
activate :blog do |blog|
  blog.layout = "articles"
  blog.permalink = ":title"
  blog.sources = File.join(LOCALE, ":year-:month-:day-:title.html")
  blog.prefix = "articles"
end

# Ignore articles from other locales than the current
other_locales = SETTINGS.keys.reject { |key, _values| key == LOCALE }
articles_not_in_current_locale = \
  %r|^articles\/(#{other_locales.join("|")})\/\d{4}-\d{2}-\d{2}|
ignore(articles_not_in_current_locale)

# Pretty URLs
activate :directory_indexes

# Hello World
activate :i18n, :mount_at_root => LOCALE.intern
I18n.locale = LOCALE

# Reload automatically when stuff changes
activate :livereload, :host => "localhost"

# # Use a familiar asset pipeline...
# activate :sprockets

# Use Webpack for building our assets
activate :external_pipeline,
  :name => :webpack,
  :command => if build?
                "./node_modules/webpack/bin/webpack.js --bail -p"
              else
                "./node_modules/webpack/bin/webpack.js --watch -d --progress --color"
  end,
  :source => ".tmp/webpack-build",
  :latency => 1

data.projects.each do |_key, attributes|
  case_study = (attributes.case_studies || []).include?(I18n.locale.to_s)
  next unless case_study

  proxy \
    File.join("/work", attributes.slug, "index.html"),
    "/work/case_study.html",
    :locals => {:project => attributes},
    :ignore => true
end

# Build-specific configuration
configure :build do
  config[:protocol] = SITE_SETTINGS["protocol"]
  config[:host] = SITE_SETTINGS["domain"]

  activate :favicon_maker, :icons => {
    "images/favicon_template.png" =>   [
      {:icon => "images/apple-touch-icon-152x152-precomposed.png"},
      {:icon => "images/apple-touch-icon-144x144-precomposed.png"},
      {:icon => "images/apple-touch-icon-114x114-precomposed.png"},
      {:icon => "images/apple-touch-icon-72x72-precomposed.png"},
      {:icon => "images/apple-touch-icon-precomposed.png", :size => "57x57"},
      {:icon => "images/apple-touch-icon.png", :size => "57x57"},
      {:icon => "images/favicon.png", :size => "16x16"},
      {:icon => "images/favicon.ico", :size => "64x64,32x32,24x24,16x16"},
      {:icon => "images/mstile-144x144", :format => "png"}
    ]
  }

  # Minify all the things
  activate :minify_html
  activate :minify_javascript
end
