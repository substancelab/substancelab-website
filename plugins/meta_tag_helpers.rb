# frozen_string_literal: true

require "cgi"

module MetaTagHelpers
  def set_meta_tags(tags = {})
    @_meta_tags ||= {}
    @_meta_tags.merge!(tags)
  end

  def auto_display_meta_tags
    tags = @_meta_tags || {}
    result = []

    title_parts = [tags[:title], tags[:site]].compact.map(&:to_s).reject(&:empty?)
    result << "<title>#{CGI.escapeHTML(title_parts.join(" | "))}</title>" if title_parts.any?

    if tags[:description]
      result << "<meta name=\"description\" content=\"#{CGI.escapeHTML(tags[:description].to_s)}\">"
    end

    if tags[:thumbnail]
      result << "<meta property=\"og:image\" content=\"#{tags[:thumbnail]}\">"
    end

    if tags[:url]
      result << "<link rel=\"canonical\" href=\"#{tags[:url]}\">"
      result << "<meta property=\"og:url\" content=\"#{tags[:url]}\">"
    end

    if tags[:locale]
      result << "<meta property=\"og:locale\" content=\"#{tags[:locale]}\">"
    end

    result.join("\n").html_safe
  end
end
