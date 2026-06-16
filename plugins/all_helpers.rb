# frozen_string_literal: true

require "active_support/core_ext/string/output_safety"
require "active_support/core_ext/array/conversions"
require "cgi"
require "uri"
require "ostruct"

require_relative "cloudinary_helpers"
require_relative "asset_helpers"
require_relative "html_helpers"
require_relative "i18n_helpers"
require_relative "navigation_helpers"
require_relative "layout_helpers"
require_relative "meta_tag_helpers"
require_relative "hero_helpers"
require_relative "article_helpers"
require_relative "client_helpers"
require_relative "project_helpers"

module AllHelpers
  SITE_HELPERS = [
    ::CloudinaryHelpers,
    ::AssetHelpers,
    ::HTMLHelpers,
    ::I18nHelpers,
    ::NavigationHelpers,
    ::LayoutHelpers,
    ::MetaTagHelpers,
    ::HeroHelpers,
    ::ArticleHelpers,
    ::ClientHelpers,
    ::ProjectHelpers,
  ].freeze

  SITE_HELPERS.each do |mod|
    Bridgetown::RubyTemplateView::Helpers.include(mod)
  end
end
