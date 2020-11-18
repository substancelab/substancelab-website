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
    title = title.to_s.strip

    site_name = "Substance Lab"
    return "#{site_name} - Grow online" if title.blank?
    return title if title.include?(site_name)

    max_page_title_length = 60
    suffix = " | #{site_name}"
    if title.length < max_page_title_length - suffix.length
      "#{title}#{suffix}"
    else
      title
    end
  end
end
