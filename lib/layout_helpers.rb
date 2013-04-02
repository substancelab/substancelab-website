module LayoutHelpers

  def body_attributes
    data = current_page.data
    attrs = {}
    attrs[:id] = data.section if data.section
    attrs[:class] = (data.body_classes).join(" ") if data.body_classes && data.body_classes.any?
    attrs
  end

end
