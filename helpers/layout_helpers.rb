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

  def masthead_image(image_url)
    return unless image_url
    content_for(:page_specific_style) do
      content_tag(:style) do
        css_for_masthead_image(image_url)
      end
    end
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

  def css_for_masthead_image(image_url)
    stylesheets_source_path = File.join(app.config.source, app.config.css_dir)
    options = {
      :load_paths => [stylesheets_source_path],
      :syntax => :sass
    }

    template_path = "assets/stylesheets/modules/_masthead_image.sass"
    template = File.readlines(template_path).join
    renderer = SassC::Engine.new(template, options)

    css = renderer.render

    # We can't pass variables to the template, so using low-level string
    # replacement to get the image in there
    css.gsub(
      'url("<image_url_goes_here>")',
      "url('#{image_url}')"
    )
  end
end
