# frozen_string_literal: true

module LayoutHelpers
  def body_attributes
    data = view.resource.data
    attrs = {}
    attrs[:id] = data.section if data.respond_to?(:section) && data.section
    classes = data.respond_to?(:body_classes) && data.body_classes
    if classes && classes.any?
      attrs[:class] = classes.join(" ")
    end
    attrs.map { |k, v| " #{k}=\"#{v}\"" }.join
  end
end
