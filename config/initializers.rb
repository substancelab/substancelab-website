# frozen_string_literal: true

require "i18n"

LOCALE = ENV["LOCALE"] || "en"

SETTINGS = {
  "da" => {
    "description" => "Eksperter i at udvikle teknikken bag succesfulde online startups.",
    "domain" => "substancelab.dk",
    "locale" => "da_DK",
    "protocol" => "https://",
  },
  "en" => {
    "description" => "We build and grow the tech behind successful SaaS startups.",
    "domain" => "substancelab.com",
    "locale" => "en_US",
    "protocol" => "https://",
  }
}.freeze
SITE_SETTINGS = SETTINGS.fetch(LOCALE)

Bridgetown.configure do |config|
  config.locale = LOCALE.to_sym
  config.default_locale = LOCALE.to_sym
  config.available_locales = SETTINGS.keys.map(&:to_sym)
  config.url = "#{SITE_SETTINGS["protocol"]}#{SITE_SETTINGS["domain"]}"

  template_engine "erb"
end

I18n.load_path += Dir[File.join(File.expand_path("../locales", __dir__), "*.yml")]
I18n.available_locales = SETTINGS.keys.map(&:to_sym)
I18n.locale = LOCALE.to_sym
I18n.default_locale = LOCALE.to_sym
