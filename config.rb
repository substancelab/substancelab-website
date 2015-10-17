LOCALE = ENV["LOCALE"] || I18n.default_locale.to_s

# Configure site
SETTINGS = {
  "da" => {
    "domain" => "substancelab.dk"
  },
  "en" => {
    "domain" => "substancelab.com"
  }
}
SITE_SETTINGS = SETTINGS[LOCALE]
# Expose configuration to the entire Middleman application
SITE_SETTINGS.each do |key, value|
  set(key.intern, value)
end

require "sassy-math"

require "slim"
Slim::Engine.set_default_options(:format => :html5,
                                 :pretty => true)

set :css_dir, "stylesheets"
set :js_dir, "javascripts"
set :images_dir, "images"

# Add asset hash to URLs
activate :asset_hash

# Blogging
activate :blog do |blog|
  blog.permalink = ":title"
  blog.sources = File.join(LOCALE, ":year-:month-:day-:title.html")
  blog.prefix = "articles"
end
page "articles/*", :layout => :articles

# Ignore articles from other locales than the current
other_locales = SETTINGS.keys.reject { |key, _values| key == LOCALE }
articles_not_in_current_locale = /^articles\/(#{other_locales.join("|")})\/\d{4}-\d{2}-\d{2}/
ignore(articles_not_in_current_locale)

# Pretty URLs
activate :directory_indexes

# Hello World
activate :i18n, :mount_at_root => LOCALE
I18n.locale = LOCALE

# Reload automatically when stuff changes
activate :livereload, :host => "localhost"

require "lib/i18n_helpers"
helpers I18nHelpers

require "lib/article_helpers"
helpers ArticleHelpers

require "lib/asset_helpers"
helpers AssetHelpers

require "lib/client_helpers"
helpers ClientHelpers

require "lib/html_helpers"
helpers HtmlHelpers

require "lib/i18n_helpers"
helpers I18nHelpers

require "lib/layout_helpers"
helpers LayoutHelpers

require "lib/project_helpers"
helpers ProjectHelpers

case_studies.each do |case_study|
  proxy File.join("/work", case_study.slug, "index.html"), "/work/case_study.html", :locals => {:project => case_study}, :ignore => true
end

# Build-specific configuration
configure :build do
  activate :favicon_maker, :icons => {
    "/images/favicon_template.png" =>   [
      {:icon => "/images/apple-touch-icon-152x152-precomposed.png"},
      {:icon => "/images/apple-touch-icon-144x144-precomposed.png"},
      {:icon => "/images/apple-touch-icon-114x114-precomposed.png"},
      {:icon => "/images/apple-touch-icon-72x72-precomposed.png"},
      {:icon => "/images/apple-touch-icon-precomposed.png", :size => "57x57"},
      {:icon => "/images/apple-touch-icon.png", :size => "57x57"},
      {:icon => "/images/favicon.png", :size => "16x16"},
      {:icon => "/images/favicon.ico", :size => "64x64,32x32,24x24,16x16"},
      {:icon => "/images/mstile-144x144", :format => "png"}
    ]
  }

  # Minify all the things
  activate :minify_css
  activate :minify_html
  activate :minify_javascript
end
