# frozen_string_literal: true

require "cgi"

module LayoutHelpers
  def body_attributes
    data = view.resource.data
    attrs = {}
    attrs[:id] = data[:section] if data[:section]
    classes = Array(data[:body_classes])
    attrs[:class] = classes.join(" ") if classes.any?
    attrs.map { |k, v| " #{k}=\"#{CGI.escapeHTML(v.to_s)}\"" }.join.html_safe
  end
end
