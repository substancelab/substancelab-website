# frozen_string_literal: true

module MastheadHelpers
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

  def masthead_image(image_url)
    return unless image_url

    if cloudinary_image_path?(image_url)
      # Cloudinary image identifier formatted like
      #
      #   "v1571230808/substancelab-website/code-keyboard.jpg"
      #
      # Run the masthead transformation on it
      transformations = [
        "t_masthead", # Masthead art-direction
        "w_1000", # Reduce image weight,
        "f_auto",
      ]
      image_url = image_url.split(".").first
      image_url = cloudinary_image_url(image_url, transformations)
    end

    content_for(:page_specific_style) do
      content_tag(:style) do
        css_for_masthead_image(image_url)
      end
    end
  end
end
