# frozen_string_literal: true

module LayoutHelpers
  def body_attributes
    data = current_page.data
    attrs = {}
    attrs[:id] = data.section if data.section
    if data.body_classes && data.body_classes.any?
      attrs[:class] = data.body_classes.join(" ")
    end
    attrs
  end
end
