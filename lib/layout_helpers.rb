module LayoutHelpers

  def body_attributes
    data = current_page.data
    attrs = {}
    attrs[:id] = data.section if data.section
    attrs[:class] = (data.body_classes).join(" ") if data.body_classes && data.body_classes.any?
    attrs
  end

  def page_title
    title = if content_for?(:page_title)
      yield_content :page_title
    else
      current_page.data.title
    end

    if title.blank?
      "Substance Lab - Carefully crafted web applications and websites"
    else
      "#{title} | Substance Lab"
    end
  end

end
