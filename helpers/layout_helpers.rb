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

  def page_title
    title = if content_for?(:page_title)
      yield_content :page_title
    else
      current_page.data.title
    end

    if title.blank?
      "Substance Lab - Grow online"
    else
      "#{title} | Substance Lab"
    end
  end
end
