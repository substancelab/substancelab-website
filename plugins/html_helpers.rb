# frozen_string_literal: true

require "cgi"
require "erb"
require "rails-html-sanitizer"
require "kramdown"
require "kramdown-parser-gfm"

module HTMLHelpers
  def strip_tags(html)
    Rails::Html::FullSanitizer.new.sanitize(html.to_s)
  end

  def content_tag(name, content = nil, options = {}, &block)
    if block_given?
      options = content if content.is_a?(Hash)
      content = yield
    end
    attrs = options.map { |k, v| " #{k}=\"#{CGI.escapeHTML(v.to_s)}\"" }.join
    "<#{name}#{attrs}>#{content}</#{name}>".html_safe
  end

  def markdown(text = nil)
    text = yield if block_given? && text.nil?
    Kramdown::Document.new(text.to_s.strip, :input => "GFM", :hard_wrap => false).to_html.html_safe
  end

  def mail_to(email, name = nil, options = {})
    name ||= email
    subject = options[:subject]
    href = "mailto:#{email}"
    # Mail clients don't decode + as a space, like browsers do in URLs
    href += "?subject=#{ERB::Util.url_encode(subject)}" if subject
    "<a href=\"#{href}\">#{name}</a>".html_safe
  end
end
